Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9868F551F79
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 16:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240070AbiFTO5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 10:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbiFTO4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:56:31 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3100F3F8B5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 07:15:21 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 73-20020a17090a0fcf00b001eaee69f600so10439000pjz.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 07:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DmB//D/LSYNMnH2xgULemxOw5o9iappAp34jQZEddSs=;
        b=o8egWsj4lRXnkeqxXw5VHRYIVps5VdNa+CzcHJyE0Pb4iMGV1/XbJaRtH4lr2qAu8v
         xtPrFYbZ10e2h6/ilbEdyDpSY1GPoh7VhivaCg7xX0nut2tSuk2ULYxiL/2rg4/vfmH5
         LCv1wbpSeTpoE4Gj/TDg9AB4Vf1pEFWUrb7tYba9ABbn28uWDjxMrH3EuooTEZAQaNjV
         ZSujm5/hY4PLGGhvTSRf8LVuI2j6RihtdMgattmCrta5AI2lhFRx/aUpBdKUPV+6M7lW
         NmcPC4CRHfdznRLNYKEI8h0KHJIgyfeCsLLsXjjpYvfZYP3r08UJulZyjyWs+rSrmLJK
         bkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DmB//D/LSYNMnH2xgULemxOw5o9iappAp34jQZEddSs=;
        b=FxtL9KnVCJ9m80Vse3LVgcR0iMHuDXqOaQE4MBx97c4mpR1EuPsZ+8wD5orBbD4y+A
         ErYj+uSKIErL8IO+cvbOhTsJNL6B4pJ9c+BLRFM7bQiigYm2cT5Ltyf0stzu56a97+OI
         SU2bogl3eme4Jj2G4AJ0keVQghBrNSgwoxP4gKxy1anCbswVZpSqP4vsIrQQTmZiAkzo
         Cm1YirQc4+g70ziuQmknlnF+oAe1r7cIPjj9iojPKIqI2Jf9lFofqo4NZ4pxu+0qBhMU
         dtU6ReD8mqNV1jlA2S4I8Lvv3RN2Jc4Wft+AsXe4fN0a8heaMvPwbDCwAuquO7S41vG3
         z+cA==
X-Gm-Message-State: AJIora9mS+J4NRnG2I2AKA6ih6seGwL7SoGAgnZLpDUqQTlrjOFGER+u
        zxDIsdPvrkmSpmJqTj4FahL2Gg==
X-Google-Smtp-Source: AGRyM1ugU+bQTMidOzp4N2Fc4lbEHGZc7loK2/xuGSo+EKAp7FqeMBjuC/KX7MpamF+73pMUL1RIUA==
X-Received: by 2002:a17:902:6941:b0:168:b5f7:4bce with SMTP id k1-20020a170902694100b00168b5f74bcemr24176394plt.104.1655734520698;
        Mon, 20 Jun 2022 07:15:20 -0700 (PDT)
Received: from localhost ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id o12-20020a62f90c000000b0051be16492basm9202042pfh.195.2022.06.20.07.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 07:15:20 -0700 (PDT)
Date:   Mon, 20 Jun 2022 22:15:16 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     akpm@linux-foundation.org, corbet@lwn.net, david@redhat.com,
        mike.kravetz@oracle.com, paulmck@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v5 2/2] mm: memory_hotplug: make hugetlb_optimize_vmemmap
 compatible with memmap_on_memory
Message-ID: <YrCA9JIet7RulSPo@FVFYT0MHHV2J.usts.net>
References: <20220620110616.12056-1-songmuchun@bytedance.com>
 <20220620110616.12056-3-songmuchun@bytedance.com>
 <YrBz5dBpb3XTZm5c@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YrBz5dBpb3XTZm5c@localhost.localdomain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 03:19:33PM +0200, Oscar Salvador wrote:
> On Mon, Jun 20, 2022 at 07:06:16PM +0800, Muchun Song wrote:
> > +		/*
> > +		 * The READ_ONCE() is used to stabilize *pmdp in a register or
> > +		 * on the stack so that it will stop changing under the code.
> > +		 * The only concurrent operation where it can be changed is
> > +		 * split_vmemmap_huge_pmd() (*pmdp will be stable after this
> > +		 * operation).
> > +		 */
> > +		pmd = READ_ONCE(*pmdp);
> > +		if (pmd_leaf(pmd))
> > +			vmemmap_page = pmd_page(pmd) + pte_index(vaddr);
> > +		else
> > +			vmemmap_page = pte_page(*pte_offset_kernel(pmdp, vaddr));
> 
> I was about to suggest to get rid of the else branch because on x86_64
> we can only allocate PMD_SIZE chunks when using an alternative allocator,
> meaning that anything which is not a pmd_leaf can't be a PageVmemmapSelfHosted.
>

You are right. However, I think relaying on this condition is fragile and
not straightforward compared to the check of PageVmemmapSelfHosted(). And
the else branch is not in a hot path. So I'd like to stay with it. Does
this make sense for you?
 
> But then I went to check the other platform that supports memmap_on_memory (arm64),
> and in there I can see that we fallback to populate basepages with altmap should
> we fail to allocate a PMD_SIZE chunk.
> 

I think it cannot be fail for memmap_on_memory case.

Thanks.

