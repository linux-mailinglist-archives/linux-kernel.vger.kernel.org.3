Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBB1532BB4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 15:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237934AbiEXNxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 09:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiEXNxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 09:53:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87F913D13;
        Tue, 24 May 2022 06:52:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C8C961638;
        Tue, 24 May 2022 13:52:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7786CC385AA;
        Tue, 24 May 2022 13:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653400378;
        bh=STLMhacHl2AWzy+G9RHYcojTiEvQVA6j5evH9G5s9Zk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aEEVfvhTm/iy3uXXblT6eftV1oQ2Mqfmu5UZXpotce+AeLjMCEvLhcLq1NsAsx/mF
         9aOQyRAExiU3mqg+ztMj7KMAEvhotfcsymhln6gUjTpbSOzbYZRkhloVofrFPHyhPK
         H16n/uM1p5rW2jsGTk4+a3XQ9/bNdJCdIlC36l5BXqVwXCPfQCHdcyGAktMfhfAFWn
         9DGUkubUzDs8TPErx1UAkMRyTv8q9awK5O9U0vLaxyUxRtX2IHOsfQ0l0WF4tXqx7z
         +nxV/EuMPRIbdXyYZu2z6ycToGbqYucrk6oz9gjdwpQujyZrTp7InX9LMW7jWq+RTu
         CcoH1YQvrjEgQ==
Date:   Tue, 24 May 2022 19:22:50 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Prasad Sodagudi <quic_psodagud@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH] mailbox: qcom-ipcc: Fix -Wunused-function with
 CONFIG_PM_SLEEP=n
Message-ID: <20220524135250.GC5745@thinkpad>
References: <20220523224702.2002652-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220523224702.2002652-1-nathan@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 03:47:02PM -0700, Nathan Chancellor wrote:
> When CONFIG_PM_SLEEP is not set, there is a warning that
> qcom_ipcc_pm_resume() is unused:
> 
>   drivers/mailbox/qcom-ipcc.c:258:12: error: 'qcom_ipcc_pm_resume' defined but not used [-Werror=unused-function]
>     258 | static int qcom_ipcc_pm_resume(struct device *dev)
>         |            ^~~~~~~~~~~~~~~~~~~
>   cc1: all warnings being treated as errors
> 
> Commit 1a3c7bb08826 ("PM: core: Add new *_PM_OPS macros, deprecate old
> ones") reworked the PM_OPS macros to avoid this problem. Use
> NOIRQ_SYSTEM_SLEEP_PM_OPS directly so that qcom_ipcc_pm_resume() always
> appears to be used to the compiler, even though it will be dead code
> eliminated in the !CONFIG_PM_SLEEP case.
> 
> Fixes: c25f77899753 ("mailbox: qcom-ipcc: Log the pending interrupt during resume")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

My bad, I missed this. Thanks for the fix!

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/mailbox/qcom-ipcc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mailbox/qcom-ipcc.c b/drivers/mailbox/qcom-ipcc.c
> index 2583b20cdeb7..31d58b7d55fe 100644
> --- a/drivers/mailbox/qcom-ipcc.c
> +++ b/drivers/mailbox/qcom-ipcc.c
> @@ -344,7 +344,7 @@ static const struct of_device_id qcom_ipcc_of_match[] = {
>  MODULE_DEVICE_TABLE(of, qcom_ipcc_of_match);
>  
>  static const struct dev_pm_ops qcom_ipcc_dev_pm_ops = {
> -	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(NULL, qcom_ipcc_pm_resume)
> +	NOIRQ_SYSTEM_SLEEP_PM_OPS(NULL, qcom_ipcc_pm_resume)
>  };
>  
>  static struct platform_driver qcom_ipcc_driver = {
> 
> base-commit: bca1a1004615efe141fd78f360ecc48c60bc4ad5
> -- 
> 2.36.1
> 

-- 
மணிவண்ணன் சதாசிவம்
