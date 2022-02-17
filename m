Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A214B9BFB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 10:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238627AbiBQJ0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 04:26:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiBQJ0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 04:26:41 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF89634B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 01:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645089985; x=1676625985;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qceDIk6fShH4bjNsZhrpzgHMTaQ402bs+RNbTC98hLY=;
  b=IsDG4rksOPesQQdONd+qxESO+ZNYA5E87j8fQziVcq/cfh3PRNUif1V5
   HoTH7u5Kcz+RZ6/RcvskYuhc+YDXrq0+0QKODAT21q+amGnsrtrpmInv1
   OwgCEs1esZIjdRc6CJxgv7woatkq3YdLvAoNMqM64o1gYgBx2sjgb/bal
   uIF/hPQzTbiiKIeHuHddug63oSffCjRDOnqi3SSNmb5UpG8/32stXT70b
   rQNDsGhIMPtvNL2y0vOrH5U07DrMzfIQm6Ne2QcsS5YTfE83WsmplraZD
   bYv4gGwuchnsnbQtYmo3EcxEzlkXPjs8Ha4XVQ6IgUzXVY7QhUxUxPflw
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="314103057"
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="314103057"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 01:26:24 -0800
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="530070662"
Received: from markorti-mobl.ger.corp.intel.com (HELO [10.213.216.21]) ([10.213.216.21])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 01:26:21 -0800
Message-ID: <9910e85e-334d-7ceb-f7f2-6fc25eaacf1e@linux.intel.com>
Date:   Thu, 17 Feb 2022 09:26:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Intel-gfx] [PATCH v7 1/5] drm/i915/gsc: add gsc as a mei
 auxiliary device
Content-Language: en-US
To:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
References: <20220213103215.2440248-1-alexander.usyskin@intel.com>
 <20220213103215.2440248-2-alexander.usyskin@intel.com>
 <f88b7780-cf4f-d2f5-f2ba-cd3d7bf2a0d4@linux.intel.com>
 <MW3PR11MB465112EBAFF7BC9681EF2D03ED349@MW3PR11MB4651.namprd11.prod.outlook.com>
 <7ed77377-1e6e-4329-1fda-87854f9bb938@linux.intel.com>
 <MW3PR11MB46512DE0897242041BAE055EED359@MW3PR11MB4651.namprd11.prod.outlook.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <MW3PR11MB46512DE0897242041BAE055EED359@MW3PR11MB4651.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/02/2022 17:14, Usyskin, Alexander wrote:
> 
> 
>> -----Original Message-----
>> From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
>> Sent: Wednesday, February 16, 2022 14:04
>> To: Usyskin, Alexander <alexander.usyskin@intel.com>; Greg Kroah-
>> Hartman <gregkh@linuxfoundation.org>; Jani Nikula
>> <jani.nikula@linux.intel.com>; Joonas Lahtinen
>> <joonas.lahtinen@linux.intel.com>; Vivi, Rodrigo <rodrigo.vivi@intel.com>;
>> David Airlie <airlied@linux.ie>; Daniel Vetter <daniel@ffwll.ch>
>> Cc: linux-kernel@vger.kernel.org; Winkler, Tomas
>> <tomas.winkler@intel.com>; Lubart, Vitaly <vitaly.lubart@intel.com>; intel-
>> gfx@lists.freedesktop.org
>> Subject: Re: [Intel-gfx] [PATCH v7 1/5] drm/i915/gsc: add gsc as a mei
>> auxiliary device
>>
>>
>>
>> On 15/02/2022 15:22, Usyskin, Alexander wrote:
>>
>>>>> +{
>>>>> +	irq_set_chip_and_handler_name(irq, &gsc_irq_chip,
>>>>> +				      handle_simple_irq, "gsc_irq_handler");
>>>>> +
>>>>> +	return irq_set_chip_data(irq, dev_priv);
>>>>
>>>> I am not familiar with this interrupt scheme - does dev_priv get used at
>>>> all by handle_simple_irq, or anyone, after being set here?
>>
>> What about this? Is dev_priv required or you could pass in NULL just as
>> well?
>>
> 
> It is not used, will remove
> 
>>>>
>>>>> +}
>>>>> +
>>>>> +struct intel_gsc_def {
>>>>> +	const char *name;
>>>>> +	const unsigned long bar;
>>>>
>>>> Unusual, why const out of curiosity? And is it "bar" or "base" would be
>>>> more accurate?
>>>>
>>> Some leftover, thanks for spotting this!
>>> It is a base of bar. I prefer bar name here. But not really matter.
>>
>> Is it?
>>
>> +	adev->bar.start = def->bar + pdev->resource[0].start;
>>
>> Looks like offset on top of BAR, no?
>>
> 
> Offset on top of DG bar; but start of HECI1/2 bar too.

Ok. :)

>>>>> +{
>>>>> +	struct pci_dev *pdev = to_pci_dev(dev_priv->drm.dev);
>>>>> +	struct mei_aux_device *adev;
>>>>> +	struct auxiliary_device *aux_dev;
>>>>> +	const struct intel_gsc_def *def;
>>>>> +	int ret;
>>>>> +
>>>>> +	intf->irq = -1;
>>>>> +	intf->id = intf_id;
>>>>> +
>>>>> +	if (intf_id == 0 && !HAS_HECI_PXP(dev_priv))
>>>>> +		return;
>>>>
>>>> Isn't inf_id == 0 always a bug with this patch, regardless of
>>>> HAS_HECI_PXP, since the support is incomplete in this patch? If so I'd
>>>> be more comfortable with a plain drm_WARN_ON_ONCE(intf_id == 0).
>>>>
>>> There will be patches for other cards that have pxp as soon as this is
>> reviewed.
>>> It is better to have infra prepared for two heads.
>>
>> My point is things are half-prepared since you don't have the id 0 in
>> the array, regardless of the HAS_HECI_PXP. Yes it can't be true now, but
>> if you add a patch which enables it to be true, you have to modify the
>> array at the same time or risk a broken patch in the middle.
>>
>> I don't see the point of the condition making it sound like there are
>> two criteria to enter below, while in fact there is only one in current
>> code, and that it that it must not be entered because array is incomplete!
>>
> 
> We initialize both cells in gsc->intf array, the first one with defaults (two lines before this line)
> for systems without working PXP, like DG1.
> The code on GSC level does not know that we don't have PXP and don't want to know.

By defaults you mean "-1" ?

My point is intel_gsc_def_dg1[] does not contain anything valid for 
interface zero. If you change HAS_HECI_PXP to return true, the code 
below does:

   def = &intel_gsc_def_dg1[intf_id];

And points to template data not populated.

So you have to change two in conjuction. Hence safest code for this 
patch would simply be:

   if (intf_id == 0) {
	drm_WARN_ON_ONCE(, "Code not implemented yet!\n");
	return;
    }

When you add entries to intel_gsc_def_dg1[] in a later series/patch, 
then you simply remove the above lines altogether.

> 
>>>>> +
>>>>> +	if (!HAS_HECI_GSC(gt->i915))
>>>>> +		return;
>>>>
>>>> Likewise?
>>>>
>>>>> +
>>>>> +	if (gt->gsc.intf[intf_id].irq <= 0) {
>>>>> +		DRM_ERROR_RATELIMITED("error handling GSC irq: irq not
>>>> set");
>>>>
>>>> Like this, but use logging functions which say which device please.
>>>>
>>> drm_err_ratelimited fits here?
>>
>> AFAICT it would be a programming bug and not something that can happen
>> at runtime hence drm_warn_on_once sounds correct for both.
>>
> 
> Sure, will do
> 
>>>>>     }
>>>>> @@ -182,6 +185,8 @@ void gen11_gt_irq_reset(struct intel_gt *gt)
>>>>>     	/* Disable RCS, BCS, VCS and VECS class engines. */
>>>>>     	intel_uncore_write(uncore, GEN11_RENDER_COPY_INTR_ENABLE,
>>>> 0);
>>>>>     	intel_uncore_write(uncore, GEN11_VCS_VECS_INTR_ENABLE,	  0);
>>>>> +	if (HAS_HECI_GSC(gt->i915))
>>>>> +		intel_uncore_write(uncore,
>>>> GEN11_GUNIT_CSME_INTR_ENABLE, 0);
>>>>>
>>>>>     	/* Restore masks irqs on RCS, BCS, VCS and VECS engines. */
>>>>>     	intel_uncore_write(uncore, GEN11_RCS0_RSVD_INTR_MASK,	~0);
>>>>> @@ -195,6 +200,8 @@ void gen11_gt_irq_reset(struct intel_gt *gt)
>>>>>     	intel_uncore_write(uncore, GEN11_VECS0_VECS1_INTR_MASK,
>>>> 	~0);
>>>>>     	if (HAS_ENGINE(gt, VECS2) || HAS_ENGINE(gt, VECS3))
>>>>>     		intel_uncore_write(uncore,
>>>> GEN12_VECS2_VECS3_INTR_MASK, ~0);
>>>>> +	if (HAS_HECI_GSC(gt->i915))
>>>>> +		intel_uncore_write(uncore,
>>>> GEN11_GUNIT_CSME_INTR_MASK, ~0);
>>>>>
>>>>>     	intel_uncore_write(uncore,
>>>> GEN11_GPM_WGBOXPERF_INTR_ENABLE, 0);
>>>>>     	intel_uncore_write(uncore,
>>>> GEN11_GPM_WGBOXPERF_INTR_MASK,  ~0);
>>>>> @@ -209,6 +216,7 @@ void gen11_gt_irq_postinstall(struct intel_gt *gt)
>>>>>     {
>>>>>     	struct intel_uncore *uncore = gt->uncore;
>>>>>     	u32 irqs = GT_RENDER_USER_INTERRUPT;
>>>>> +	const u32 gsc_mask = GSC_IRQ_INTF(0) | GSC_IRQ_INTF(1);
>>>>
>>>> Why enable the one which is not supported by the patch? No harm doing
>> it?
>>>>
>>> No harm and the next patch will be soon, this patch unfortunately is long
>> overdue.
>>
>> Just feels a bit lazy. You are adding two feature test macros to
>> prepare, so why not use them.
>>
> 
> I've been told that better to enable them both from the HW perspective,
> the real interrupt enable magic happens in GSC FW, not here.

Well whatever.. As long as logging of spurious/unexpected interrupts is 
in place I can live with that.

Regards,

Tvrtko
