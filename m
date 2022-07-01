Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D817563381
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 14:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235241AbiGAMe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 08:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbiGAMe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 08:34:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0455036159
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 05:34:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC7FC113E;
        Fri,  1 Jul 2022 05:34:54 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6276D3F792;
        Fri,  1 Jul 2022 05:34:53 -0700 (PDT)
Date:   Fri, 1 Jul 2022 13:34:50 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     huhai <15815827059@163.com>
Cc:     cristian.marussi@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, luriwen@kylinos.cn,
        liuyun01@kylinos.cn, huhai <huhai@kylinos.cn>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: arm_scpi: Fix error handle when scpi probe
 failed
Message-ID: <20220701123450.rdqffbyubuu63iph@bogus>
References: <20220701061606.151366-1-15815827059@163.com>
 <20220701094212.snsnbdjc7hia5oti@bogus>
 <1752bac0.5d05.181b93873da.Coremail.15815827059@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1752bac0.5d05.181b93873da.Coremail.15815827059@163.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 06:04:53PM +0800, huhai wrote:
> 
> scpi_info is a global variable， we must set it to NULL when it is not valid

How about not assigning the global variable until the end of the probe ?
Something like below:

Regards,
Sudeep

-->8

diff --git i/drivers/firmware/arm_scpi.c w/drivers/firmware/arm_scpi.c
index ddf0b9ff9e15..5463501735ff 100644
--- i/drivers/firmware/arm_scpi.c
+++ w/drivers/firmware/arm_scpi.c
@@ -913,13 +913,14 @@ static int scpi_probe(struct platform_device *pdev)
        struct resource res;
        struct device *dev = &pdev->dev;
        struct device_node *np = dev->of_node;
+       struct scpi_drvinfo *scpi_drvinfo;

-       scpi_info = devm_kzalloc(dev, sizeof(*scpi_info), GFP_KERNEL);
-       if (!scpi_info)
+       scpi_drvinfo = devm_kzalloc(dev, sizeof(*scpi_drvinfo), GFP_KERNEL);
+       if (!scpi_drvinfo)
                return -ENOMEM;

        if (of_match_device(legacy_scpi_of_match, &pdev->dev))
-               scpi_info->is_legacy = true;
+               scpi_drvinfo->is_legacy = true;

        count = of_count_phandle_with_args(np, "mboxes", "#mbox-cells");
        if (count < 0) {
@@ -927,19 +928,19 @@ static int scpi_probe(struct platform_device *pdev)
                return -ENODEV;
        }

-       scpi_info->channels = devm_kcalloc(dev, count, sizeof(struct scpi_chan),
-                                          GFP_KERNEL);
-       if (!scpi_info->channels)
+       scpi_drvinfo->channels =
+               devm_kcalloc(dev, count, sizeof(struct scpi_chan), GFP_KERNEL);
+       if (!scpi_drvinfo->channels)
                return -ENOMEM;

-       ret = devm_add_action(dev, scpi_free_channels, scpi_info);
+       ret = devm_add_action(dev, scpi_free_channels, scpi_drvinfo);
        if (ret)
                return ret;

-       for (; scpi_info->num_chans < count; scpi_info->num_chans++) {
+       for (; scpi_drvinfo->num_chans < count; scpi_drvinfo->num_chans++) {
                resource_size_t size;
-               int idx = scpi_info->num_chans;
-               struct scpi_chan *pchan = scpi_info->channels + idx;
+               int idx = scpi_drvinfo->num_chans;
+               struct scpi_chan *pchan = scpi_drvinfo->channels + idx;
                struct mbox_client *cl = &pchan->cl;
                struct device_node *shmem = of_parse_phandle(np, "shmem", idx);

@@ -986,43 +987,44 @@ static int scpi_probe(struct platform_device *pdev)
                return ret;
        }

-       scpi_info->commands = scpi_std_commands;
+       scpi_drvinfo->commands = scpi_std_commands;

-       platform_set_drvdata(pdev, scpi_info);
+       platform_set_drvdata(pdev, scpi_drvinfo);

-       if (scpi_info->is_legacy) {
+       if (scpi_drvinfo->is_legacy) {
                /* Replace with legacy variants */
                scpi_ops.clk_set_val = legacy_scpi_clk_set_val;
-               scpi_info->commands = scpi_legacy_commands;
+               scpi_drvinfo->commands = scpi_legacy_commands;

                /* Fill priority bitmap */
                for (idx = 0; idx < ARRAY_SIZE(legacy_hpriority_cmds); idx++)
                        set_bit(legacy_hpriority_cmds[idx],
-                               scpi_info->cmd_priority);
+                               scpi_drvinfo->cmd_priority);
        }

-       ret = scpi_init_versions(scpi_info);
+       ret = scpi_init_versions(scpi_drvinfo);
        if (ret) {
                dev_err(dev, "incorrect or no SCP firmware found\n");
                return ret;
        }

-       if (scpi_info->is_legacy && !scpi_info->protocol_version &&
-           !scpi_info->firmware_version)
+       if (scpi_drvinfo->is_legacy && !scpi_drvinfo->protocol_version &&
+           !scpi_drvinfo->firmware_version)
                dev_info(dev, "SCP Protocol legacy pre-1.0 firmware\n");
        else
                dev_info(dev, "SCP Protocol %lu.%lu Firmware %lu.%lu.%lu version\n",
                         FIELD_GET(PROTO_REV_MAJOR_MASK,
-                                  scpi_info->protocol_version),
+                                  scpi_drvinfo->protocol_version),
                         FIELD_GET(PROTO_REV_MINOR_MASK,
-                                  scpi_info->protocol_version),
+                                  scpi_drvinfo->protocol_version),
                         FIELD_GET(FW_REV_MAJOR_MASK,
-                                  scpi_info->firmware_version),
+                                  scpi_drvinfo->firmware_version),
                         FIELD_GET(FW_REV_MINOR_MASK,
-                                  scpi_info->firmware_version),
+                                  scpi_drvinfo->firmware_version),
                         FIELD_GET(FW_REV_PATCH_MASK,
-                                  scpi_info->firmware_version));
-       scpi_info->scpi_ops = &scpi_ops;
+                                  scpi_drvinfo->firmware_version));
+       scpi_drvinfo->scpi_ops = &scpi_ops;
+       scpi_info = scpi_drvinfo;

        return devm_of_platform_populate(dev);
 }

