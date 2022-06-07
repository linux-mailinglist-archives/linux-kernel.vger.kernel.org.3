Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C83554002F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 15:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244844AbiFGNgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 09:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244804AbiFGNgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 09:36:00 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4988C6847;
        Tue,  7 Jun 2022 06:35:57 -0700 (PDT)
Received: (Authenticated sender: peter@korsgaard.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9D8144000A;
        Tue,  7 Jun 2022 13:35:54 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.94.2)
        (envelope-from <peter@korsgaard.com>)
        id 1nyYrp-00058v-Gr; Tue, 07 Jun 2022 15:03:29 +0200
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Tanmay Shah <tanmay.shah@xilinx.com>
Cc:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <michal.simek@xilinx.com>, <ben.levinsky@xilinx.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <openamp-system-reference@lists.openampproject.org>
Subject: Re: [PATCH v8 6/6] drivers: remoteproc: Add Xilinx r5 remoteproc
 driver
References: <20220602203834.3675160-1-tanmay.shah@xilinx.com>
        <20220602203834.3675160-7-tanmay.shah@xilinx.com>
Date:   Tue, 07 Jun 2022 15:03:29 +0200
In-Reply-To: <20220602203834.3675160-7-tanmay.shah@xilinx.com> (Tanmay Shah's
        message of "Thu, 2 Jun 2022 13:38:34 -0700")
Message-ID: <87pmjkwrq6.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Tanmay" == Tanmay Shah <tanmay.shah@xilinx.com> writes:

Hi,

 > This driver enables r5f dual core Real time Processing Unit subsystem
 > available on Xilinx Zynq Ultrascale MPSoC Platform. RPU subsystem
 > (cluster) can be configured in different modes e.g. split mode in which
 > two r5f cores work independent of each other and lock-step mode in which
 > both r5f cores execute same code clock-for-clock and notify if the
 > result is different.

 > The Xilinx r5 Remoteproc Driver boots the RPU cores via calls to the Xilinx
 > Platform Management Unit that handles the R5 configuration, memory access
 > and R5 lifecycle management. The interface to this manager is done in this
 > driver via zynqmp_pm_* function calls.

 > Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
 > Signed-off-by: Tanmay Shah <tanmay.shah@xilinx.com>

 > + * zynqmp_r5_set_mode - set RPU operation mode
 > + *
 > + * set RPU operation mode
 > + *
 > + * Return: 0 for success, negative value for failure
 > + */
 > +static int zynqmp_r5_set_mode(struct zynqmp_r5_core *r5_core,
 > +			      enum rpu_oper_mode fw_reg_val,
 > +			      enum rpu_tcm_comb tcm_mode)
 > +{

NIT: That is an odd name for the lockstep/split argument. Why do you
need to specify both R5F mode and TCM configuration, isn't the TCM mode
implied by the R5F mode?

-- 
Bye, Peter Korsgaard
