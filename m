Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB7B46DF14
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 00:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238166AbhLHXsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 18:48:12 -0500
Received: from relay04.th.seeweb.it ([5.144.164.165]:48939 "EHLO
        relay04.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238031AbhLHXsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 18:48:12 -0500
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id C5E412036B;
        Thu,  9 Dec 2021 00:44:37 +0100 (CET)
Date:   Thu, 9 Dec 2021 00:44:36 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Alex Elder <elder@linaro.org>
Cc:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Elliot Berman <eberman@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] firmware: qcom: scm: Add function to set the maximum
 IOMMU pool size
Message-ID: <20211208234436.ktagmcfj6jl5jct5@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Alex Elder <elder@linaro.org>, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Elliot Berman <eberman@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211208083423.22037-1-marijn.suijten@somainline.org>
 <20211208083423.22037-3-marijn.suijten@somainline.org>
 <b21686fc-3662-1ed4-8ba3-8ed5ca6eda13@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b21686fc-3662-1ed4-8ba3-8ed5ca6eda13@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-08 07:30:28, Alex Elder wrote:
> On 12/8/21 2:34 AM, Marijn Suijten wrote:
> > From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> > 
> > This is not necessary for basic functionality of the IOMMU, but
> > it's an optimization that tells to the TZ what's the maximum
> > mappable size for the secure IOMMUs, so that it can optimize
> > the data structures in the TZ itself.
> 
> Are there no users of this function?	-Alex

I should have probably mentioned in the cover letter that this function
and the one introduced in patch 3/3 are going to be used in upcoming
patches for IOMMUs found in msm8976, msm8974 and related SoCs (with the
side-note that I don't see this particular set_cp_pool_size used in the
branch that this was submitted from, but it's most likely used elsewhere
or planned ahead to be used in the near future - I expect Angelo to be
able to comment on that more accurately).

> > 
> > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> > [Marijn: ported from 5.3 to the unified architecture in 5.11]
> > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> > ---
> >   drivers/firmware/qcom_scm.c | 15 +++++++++++++++
> >   drivers/firmware/qcom_scm.h |  1 +
> >   include/linux/qcom_scm.h    |  1 +
> >   3 files changed, 17 insertions(+)
> > 
> > diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> > index 3f67bf774821..d5a9ba15e2ba 100644
> > --- a/drivers/firmware/qcom_scm.c
> > +++ b/drivers/firmware/qcom_scm.c
> > @@ -759,6 +759,21 @@ int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare)
> >   }
> >   EXPORT_SYMBOL(qcom_scm_iommu_secure_ptbl_init);
> >   
> > +int qcom_scm_iommu_set_cp_pool_size(u32 spare, u32 size)
> > +{
> > +	struct qcom_scm_desc desc = {
> > +		.svc = QCOM_SCM_SVC_MP,
> > +		.cmd = QCOM_SCM_MP_IOMMU_SET_CP_POOL_SIZE,
> > +		.arginfo = QCOM_SCM_ARGS(2),
> > +		.args[0] = size,
> > +		.args[1] = spare,
> > +		.owner = ARM_SMCCC_OWNER_SIP,
> > +	};
> > +
> > +	return qcom_scm_call(__scm->dev, &desc, NULL);
> > +}
> > +EXPORT_SYMBOL(qcom_scm_iommu_set_cp_pool_size);
> > +
> >   int qcom_scm_mem_protect_video_var(u32 cp_start, u32 cp_size,
> >   				   u32 cp_nonpixel_start,
> >   				   u32 cp_nonpixel_size)
> > diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
> > index d92156ceb3ac..bb627941702b 100644
> > --- a/drivers/firmware/qcom_scm.h
> > +++ b/drivers/firmware/qcom_scm.h
> > @@ -100,6 +100,7 @@ extern int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
> >   #define QCOM_SCM_MP_RESTORE_SEC_CFG		0x02
> >   #define QCOM_SCM_MP_IOMMU_SECURE_PTBL_SIZE	0x03
> >   #define QCOM_SCM_MP_IOMMU_SECURE_PTBL_INIT	0x04
> > +#define QCOM_SCM_MP_IOMMU_SET_CP_POOL_SIZE	0x05
> >   #define QCOM_SCM_MP_VIDEO_VAR			0x08
> >   #define QCOM_SCM_MP_ASSIGN			0x16
> >   
> > diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
> > index 81cad9e1e412..8a065f8660c1 100644
> > --- a/include/linux/qcom_scm.h
> > +++ b/include/linux/qcom_scm.h
> > @@ -83,6 +83,7 @@ extern bool qcom_scm_restore_sec_cfg_available(void);
> >   extern int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare);
> >   extern int qcom_scm_iommu_secure_ptbl_size(u32 spare, size_t *size);
> >   extern int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare);
> > +extern int qcom_scm_iommu_set_cp_pool_size(u32 spare, u32 size);
> >   extern int qcom_scm_mem_protect_video_var(u32 cp_start, u32 cp_size,
> >   					  u32 cp_nonpixel_start,
> >   					  u32 cp_nonpixel_size);
> > 
> 
