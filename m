Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B65D5AD43A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 15:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238214AbiIENpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 09:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237130AbiIENpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 09:45:07 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164E24E610
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 06:45:05 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id C6DD13200928;
        Mon,  5 Sep 2022 09:45:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 05 Sep 2022 09:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1662385502; x=1662471902; bh=yg
        aFQaIZgsPlCvGxBshcdt6jZDFSv4YrxILywAef6b8=; b=coAufvSS5LgJkML+Dv
        lLyuYw/AKPUQP2GvZSgAeHrLKFkSEk7QGwlbpqCnjpNDhZ5daNWM3UWOwuTRi0sM
        OfPO6MYqRUwp5K1W6cUpk6E3txlJW3bicoPGdy87xLZjYNbFr53oLPH1Gz01lAXd
        /YUBGMSj9mvU8WjO5VcIFlTYFZmrqo/tEBrrnOEMQHYAZIPj44qYeHD2r/VIZwdw
        6ZlIrOSlimsg5hCebvtECkBDm4HV7UvLngpOh6mxYH3IwVf2ACsdd5SbAPXHrXLs
        atHkg579fM+vVpMQukXWDOoYtUd811JHAo0YySqXs6O5pqZMYfqMAzewAmVvKDzC
        3zyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1662385502; x=1662471902; bh=ygaFQaIZgsPlCvGxBshcdt6jZDFS
        v4YrxILywAef6b8=; b=nFm8Mfc2DXB+9ZyKKBwZh78iHFJRJHN93G1ikx6tfDsi
        Lvq8gtE+UpIavRFvoMwU8zNPmUbQRtXXwnT6KN8zOFGK72WXFJZPEcl7OS5LqKqo
        fBDpgAdXHvsMvpou52fDMLmS6DsPCsUao7RqeDFOGI6dJ47MWQzwc1dok0w6OoUV
        ppyijT6WzohX3BlO+ndF3YBsM9nf55We/O64qtdHwSnhL6udto8m7dDu7WdF21vS
        pll2lZ/pXkgEjVRsgM1qRGL3l4r91QIEywa0AyOIQcFe6JEBmRx3TB/3y/OiYH/Z
        X8evXWjq/DN7R42/3DcSS5SL8GQiF1GUieA8HBOoCQ==
X-ME-Sender: <xms:Xf0VYxuT60pTvyFcH6w4Lgeis20TJjjSimBzC60dRM_fjHPP6IAhgw>
    <xme:Xf0VY6cAUtuXr_s3ExUO4I8pJg6Sq-IS1s-vHaksqrafBNm8aCVRg4oVVCGSN4zFz
    Y_mxwkF_GuJ-p6DIaY>
X-ME-Received: <xmr:Xf0VY0yp1HFRwGFtL4dItbpV9gJG7HVuAasBivGUs9jK6bMOscCgTu3fM2-YJ0kU-5HYnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeliedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeelgffhfeetlefhveffleevfffgtefffeelfedu
    udfhjeduteeggfeiheefteehjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhl
    sehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:Xv0VY4PJmcalfS2PabQZMuCpNXGwRjl6eLkq2hQ5ZTFdLJXB1lSIrQ>
    <xmx:Xv0VYx9DjlW7kFG8PrxvsnXK2hevXMMCVXwSIy4nR8sdJLyls6Muvw>
    <xmx:Xv0VY4UKW4G8Sb0tW7OxYlz2lyv_imGDuZ-7XpUSLOAwKoGIG5jwAg>
    <xmx:Xv0VY5MtUsJeiYDnV8BEysyb1t20LVr1zfBI3gZmnvY0ZWBWkAgRZA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Sep 2022 09:45:01 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id CC4821040BF; Mon,  5 Sep 2022 16:44:57 +0300 (+03)
Date:   Mon, 5 Sep 2022 16:44:57 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Bharata B Rao <bharata@amd.com>
Cc:     ananth.narayan@amd.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv8 00/11] Linear Address Masking enabling
Message-ID: <20220905134457.a2f7uluq42frsgwe@box.shutemov.name>
References: <20220830010104.1282-1-kirill.shutemov@linux.intel.com>
 <20220904010001.knlcejmw4lg2uzy3@box.shutemov.name>
 <64519d0b-b696-db47-52c2-303451e10c09@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64519d0b-b696-db47-52c2-303451e10c09@amd.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 10:35:44AM +0530, Bharata B Rao wrote:
> Hi Kirill,
> 
> On 9/4/2022 6:30 AM, Kirill A. Shutemov wrote:
> > On Tue, Aug 30, 2022 at 04:00:53AM +0300, Kirill A. Shutemov wrote:
> >> Linear Address Masking[1] (LAM) modifies the checking that is applied to
> >> 64-bit linear addresses, allowing software to use of the untranslated
> >> address bits for metadata.
> >>
> >> The patchset brings support for LAM for userspace addresses. Only LAM_U57 at
> >> this time.
> >>
> >> Please review and consider applying.
> >>
> >> git://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git lam
> > 
> > +Bharata, Ananth.
> > 
> > Do you folks have any feedback on the patchset?
> > 
> > Looks like AMD version of the tagged pointers feature does not get
> > traction as of now, but I want to be sure that the interface introduced
> > here can be suitable for your future plans.
> > 
> > Do you see anything in the interface that can prevent it to be extended to
> > the AMD feature?
> 
> The arch_prctl() extensions is generic enough that it should be good.
> 
> The untagged_addr() macro looks like this from one of the callers:
> 
>         start = untagged_addr(mm, start);
> ffffffff814d39bb:       48 8b 8d 40 ff ff ff    mov    -0xc0(%rbp),%rcx
> ffffffff814d39c2:       48 89 f2                mov    %rsi,%rdx
> ffffffff814d39c5:       48 c1 fa 3f             sar    $0x3f,%rdx
> ffffffff814d39c9:       48 0b 91 50 03 00 00    or     0x350(%rcx),%rdx
> ffffffff814d39d0:       48 21 f2                and    %rsi,%rdx
> ffffffff814d39d3:       49 89 d6                mov    %rdx,%r14
> 
> Can this overhead of a few additional instructions be removed for
> platforms that don't have LAM feature? I haven't measured how much
> overhead this effectively contributes to in real, but wonder if it is
> worth optimizing for non-LAM platforms.

I'm not sure how the optimization should look like. I guess we can stick
static_cpu_has() there, but I'm not convinced that adding jumps there will
be beneficial.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
