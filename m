Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72425A0B0A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239390AbiHYIGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239335AbiHYIGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:06:44 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F795D105
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 01:06:36 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id bh13so17224170pgb.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 01:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=eOMnW4XRMv9i7Jz+s+vzPHDgE9J0PdEgB49b5OhgITs=;
        b=RWng7N5PTYTg8iG2OuCR4VQEdNEj3/8z3epffY25IzHVo9/8oyXM+D6pNM89JJtFCh
         B1I1KZ+aeQPqg6uQv6koBzL1yrV/fYDw/3CKWsvI4Em4/mX1bMltBPqxsenl68u2jJKG
         yuHG4BmVX4ds3dsDZhe2kIEymT9YXEeljlMtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=eOMnW4XRMv9i7Jz+s+vzPHDgE9J0PdEgB49b5OhgITs=;
        b=lAf3qoJ2PT/hRJ8DauCJh738F2g2kbBIbiOq59Oqug1bvmO5UGfiH8a/pIiFI8Ogpm
         S8CClrimMKz30Ra6nMpL6afZ7dLBC4GuQWbnygA9BuJBN+9IWjJws/l3ImMKWJnpRTCh
         355ayY+/i663HhPTF5DYXq2mDBABQB6KNE8jyVdjV1IvBgJDgvufB0Knij4DKJBGcruC
         tYBAPDGqXweDQw4MekB6W5Ci4cXmKv6PEr9rHDoJpl9WGgzkPkOeyAOCT8pzQCutXu+n
         HypLM6xJ4/JS1UFltc0sDKPRJldr2msno4yaUjYXB3QVSAdDZiO1QFPgm1ydl65rsgoF
         lttA==
X-Gm-Message-State: ACgBeo0zYZsvwYKOYhVR9wwFoSbUcMIiBbrvpWtUT1148WXs8kqVEXkf
        i0P6+0/Y0/V02naINsBSgJinHg==
X-Google-Smtp-Source: AA6agR6+mJ1Wc1D3WsfiNeQ/QQf/aq+KsYyd8aXpMNYK85PM6dK+q9VbcqdMfMEdiWPQbCe0Be46uw==
X-Received: by 2002:a05:6a00:b8a:b0:537:f81:203a with SMTP id g10-20020a056a000b8a00b005370f81203amr2736459pfj.80.1661414795595;
        Thu, 25 Aug 2022 01:06:35 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:fba3:9861:f694:5325])
        by smtp.gmail.com with UTF8SMTPSA id h16-20020a170902f55000b00172ad292b6bsm5441073plf.116.2022.08.25.01.06.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 01:06:35 -0700 (PDT)
Date:   Thu, 25 Aug 2022 01:06:32 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, swboyd@chromium.org,
        dmitry.baryshkov@linaro.org,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v6] PCI/ASPM: Update LTR threshold based upon reported
 max latencies
Message-ID: <YwctiEJpydiFdIds@google.com>
References: <1657886421-779-1-git-send-email-quic_krichai@quicinc.com>
 <20220726074954.GB5522@workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220726074954.GB5522@workstation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 01:19:54PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Jul 15, 2022 at 05:30:12PM +0530, Krishna chaitanya chundru wrote:
> > In ASPM driver, LTR threshold scale and value are updated based on
> > tcommon_mode and t_poweron values. In kioxia NVMe L1.2 is failing due to
> > LTR threshold scale and value are greater values than max snoop/non-snoop
> > value.
> > 
> > Based on PCIe r4.1, sec 5.5.1, L1.2 substate must be entered when
> > reported snoop/no-snoop values is greather than or equal to
> > LTR_L1.2_THRESHOLD value.
> > 
> > Signed-off-by: Prasad Malisetty  <quic_pmaliset@quicinc.com>
> > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Bjorn, any update on this patch?

ping: can this be landed or are any further changes needed?

> Thanks,
> Mani
> 
> > ---
> > 
> > I am taking this patch forward as prasad is no more working with our org.
> > changes since v5:
> > 	- no changes, just reposting as standalone patch instead of reply to
> > 	  previous patch.
> > Changes since v4:
> > 	- Replaced conditional statements with min and max.
> > changes since v3:
> > 	- Changed the logic to include this condition "snoop/nosnoop
> > 	  latencies are not equal to zero and lower than LTR_L1.2_THRESHOLD"
> > Changes since v2:
> > 	- Replaced LTRME logic with max snoop/no-snoop latencies check.
> > Changes since v1:
> > 	- Added missing variable declaration in v1 patch
> > ---
> >  drivers/pci/pcie/aspm.c | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> > 
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index a96b742..676c03e 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -461,14 +461,36 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
> >  {
> >  	struct pci_dev *child = link->downstream, *parent = link->pdev;
> >  	u32 val1, val2, scale1, scale2;
> > +	u32 max_val, max_scale, max_snp_scale, max_snp_val, max_nsnp_scale, max_nsnp_val;
> >  	u32 t_common_mode, t_power_on, l1_2_threshold, scale, value;
> >  	u32 ctl1 = 0, ctl2 = 0;
> >  	u32 pctl1, pctl2, cctl1, cctl2;
> >  	u32 pl1_2_enables, cl1_2_enables;
> > +	u16 ltr;
> > +	u16 max_snoop_lat, max_nosnoop_lat;
> >  
> >  	if (!(link->aspm_support & ASPM_STATE_L1_2_MASK))
> >  		return;
> >  
> > +	ltr = pci_find_ext_capability(child, PCI_EXT_CAP_ID_LTR);
> > +	if (!ltr)
> > +		return;
> > +
> > +	pci_read_config_word(child, ltr + PCI_LTR_MAX_SNOOP_LAT, &max_snoop_lat);
> > +	pci_read_config_word(child, ltr + PCI_LTR_MAX_NOSNOOP_LAT, &max_nosnoop_lat);
> > +
> > +	max_snp_scale = (max_snoop_lat & PCI_LTR_SCALE_MASK) >> PCI_LTR_SCALE_SHIFT;
> > +	max_snp_val = max_snoop_lat & PCI_LTR_VALUE_MASK;
> > +
> > +	max_nsnp_scale = (max_nosnoop_lat & PCI_LTR_SCALE_MASK) >> PCI_LTR_SCALE_SHIFT;
> > +	max_nsnp_val = max_nosnoop_lat & PCI_LTR_VALUE_MASK;
> > +
> > +	/* choose the greater max scale value between snoop and no snoop value*/
> > +	max_scale = max(max_snp_scale, max_nsnp_scale);
> > +
> > +	/* choose the greater max value between snoop and no snoop scales */
> > +	max_val = max(max_snp_val, max_nsnp_val);
> > +
> >  	/* Choose the greater of the two Port Common_Mode_Restore_Times */
> >  	val1 = (parent_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
> >  	val2 = (child_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
> > @@ -501,6 +523,14 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
> >  	 */
> >  	l1_2_threshold = 2 + 4 + t_common_mode + t_power_on;
> >  	encode_l12_threshold(l1_2_threshold, &scale, &value);
> > +
> > +	/*
> > +	 * Based on PCIe r4.1, sec 5.5.1, L1.2 substate must be entered when reported
> > +	 * snoop/no-snoop values are greather than or equal to LTR_L1.2_THRESHOLD value.
> > +	 */
> > +	scale = min(scale, max_scale);
> > +	value = min(value, max_val);
> > +
> >  	ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
> >  
> >  	/* Some broken devices only support dword access to L1 SS */
> > -- 
> > 2.7.4
> > 
