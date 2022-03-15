Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10F14D9FC6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 17:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349966AbiCOQUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 12:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235918AbiCOQUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:20:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F281276F;
        Tue, 15 Mar 2022 09:18:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 841BD21901;
        Tue, 15 Mar 2022 16:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647361133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WRmt8OEVoaWOh8laJSatF97Upa9zr/MymjKkHsOXX58=;
        b=O7hwlbyVgMB+GGlS0/U8ji7SNsE8ASleMMPBvebis6D0shSbuMqZHQHjOwBJ4TaAXezmBT
        mPf1KfRsWc10PpT8hv+Jjha2++tgTLJe4dE/ZPRr0LByYE/gvwBF9v1St1bzleCkxpZVDF
        rm62SR5c6OCQmaF2YCoP7IbAIjMblKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647361133;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WRmt8OEVoaWOh8laJSatF97Upa9zr/MymjKkHsOXX58=;
        b=EYdv/BlBn6u8dFsYlEtc2T1+QqBK/ocq+WOebxmkLyaknXD3WmBg6f59oHzUZsd9yZ2QH+
        xikocBP1uf2KL6Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 46E7113B4E;
        Tue, 15 Mar 2022 16:18:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LpOoD228MGK3PAAAMHmgww
        (envelope-from <jdelvare@suse.de>); Tue, 15 Mar 2022 16:18:53 +0000
Date:   Tue, 15 Mar 2022 17:18:52 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     cgel.zte@gmail.com
Cc:     linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] hwmon: (scpi-hwmon): Use of_device_get_match_data()
Message-ID: <20220315171852.3b2f1dc4@endymion.delvare>
In-Reply-To: <20220315023412.2118415-1-chi.minghao@zte.com.cn>
References: <20220315023412.2118415-1-chi.minghao@zte.com.cn>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2022 02:34:12 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Use of_device_get_match_data() to simplify the code.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/hwmon/scpi-hwmon.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/scpi-hwmon.c b/drivers/hwmon/scpi-hwmon.c
> index 919877970ae3..5187c6dd5a4f 100644
> --- a/drivers/hwmon/scpi-hwmon.c
> +++ b/drivers/hwmon/scpi-hwmon.c
> @@ -141,7 +141,6 @@ static int scpi_hwmon_probe(struct platform_device *pdev)
>  	struct scpi_ops *scpi_ops;
>  	struct device *hwdev, *dev = &pdev->dev;
>  	struct scpi_sensors *scpi_sensors;
> -	const struct of_device_id *of_id;
>  	int idx, ret;
>  
>  	scpi_ops = get_scpi_ops();
> @@ -171,12 +170,11 @@ static int scpi_hwmon_probe(struct platform_device *pdev)
>  
>  	scpi_sensors->scpi_ops = scpi_ops;
>  
> -	of_id = of_match_device(scpi_of_match, &pdev->dev);
> -	if (!of_id) {
> +	scale = of_device_get_match_data(&pdev->dev);
> +	if (!scale) {
>  		dev_err(&pdev->dev, "Unable to initialize scpi-hwmon data\n");
>  		return -ENODEV;
>  	}
> -	scale = of_id->data;
>  
>  	for (i = 0, idx = 0; i < nr_sensors; i++) {
>  		struct sensor_data *sensor = &scpi_sensors->data[idx];

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
