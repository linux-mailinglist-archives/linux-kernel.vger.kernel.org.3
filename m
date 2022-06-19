Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E572A550D9F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 01:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbiFSXiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 19:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiFSXiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 19:38:21 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32E42635
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 16:38:19 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id w9so1103044lji.4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 16:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5wbxuLf0qXQzSxMY2PUkol4aa/X/GJBgeigo9VpDstk=;
        b=V6VYfk+wZY/WdtyFDvQGT+uCsNvT25Ac7QoIU62efffylc24tJrjFQWL/7KlTFeKtM
         VvWs2+c6CVUiq6V6zvNtNRJQ+WXY7ltdlNe7gAspvm62mG+RZVOwSxgL1bg7H23MkRcE
         NrVjkBGoVC4LeGBgLKeDuRnN8NLXFr0lcLKtHm/KiFBhtew0/IXJXz2AVJr7zAUl1vHU
         Q60UUj+4lZz6oMlDq/+es8PUXhh0TqCY0gF+ud/ZL8o++HjIrL9A97TEmc+aaWZnr/ng
         5wdS4DoqGBUyqASoMw5FgWpSV80xp4mMRZsTVxOpzCXaReYkm0BFfwfEF2kSycXMTAP0
         LwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5wbxuLf0qXQzSxMY2PUkol4aa/X/GJBgeigo9VpDstk=;
        b=rWHn2qGHx1uC1eA0pPl2eARabA30oaZX1xL0/oDxdQuHkS2ZC/8IBjYnJAhmtqjRzk
         yWdQlHpjTsG3WvOMrvQ7zkSgs+dmUrDCUE4Blkn7tbTCjcwIdhzdCTY817rVTFi4LD0O
         1JdHfAjQjJpp8xH0cyBadCepw6ExBipTvnayuxlXpDg/TR568tWsN5Fq6NkFwzvnnHeB
         wUlfJgvhLRqFVyEbylJ84gwxSdQZgl88zoc7MBlqqXm1SirAb1iYiu6VNgqan9n1iSGL
         LD87bXYacfs2MIuYmwliuhSZbUR4SBqAgvipbK09jpRyIbAs/+Es4Y8NhQQWw6YwjbMU
         jltQ==
X-Gm-Message-State: AJIora9mtdwoC9SfSeaGUJf/Jav7d4QflIPAGsslSDq7fww1hDl7wpNL
        ldjSDrM4Txuseg1pPyMetfwOMA==
X-Google-Smtp-Source: AGRyM1vFaOZ4Zgxq+10xBD3dM5r/wv1lezKMOYgUJVmLzU+ORJIC9B7O/RcxcdgF/Zn/FWwFO6oYXg==
X-Received: by 2002:a2e:a807:0:b0:25a:673b:5ae8 with SMTP id l7-20020a2ea807000000b0025a673b5ae8mr3263062ljq.68.1655681897980;
        Sun, 19 Jun 2022 16:38:17 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id m3-20020a05651202e300b0047f647414eesm624555lfq.229.2022.06.19.16.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 16:38:16 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id CA5F61036C1; Mon, 20 Jun 2022 02:40:27 +0300 (+03)
Date:   Mon, 20 Jun 2022 02:40:27 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 6/8] x86/mm: Provide ARCH_GET_UNTAG_MASK and
 ARCH_ENABLE_TAGGED_ADDR
Message-ID: <20220619234027.4irpbqxcygauvrso@box.shutemov.name>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
 <20220610143527.22974-7-kirill.shutemov@linux.intel.com>
 <YqdM8ZIi0/35IhzF@dhcp22.suse.cz>
 <20220616170510.gpm5pjd4yzk7hfsx@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616170510.gpm5pjd4yzk7hfsx@black.fi.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 08:05:10PM +0300, Kirill A. Shutemov wrote:
> On Mon, Jun 13, 2022 at 04:42:57PM +0200, Michal Hocko wrote:
> > On Fri 10-06-22 17:35:25, Kirill A. Shutemov wrote:
> > [...]
> > > diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> > > index 1962008fe743..93c8eba1a66d 100644
> > > --- a/arch/x86/kernel/process_64.c
> > > +++ b/arch/x86/kernel/process_64.c
> > > @@ -742,6 +742,32 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
> > >  }
> > >  #endif
> > >  
> > > +static int prctl_enable_tagged_addr(unsigned long nr_bits)
> > > +{
> > > +	struct mm_struct *mm = current->mm;
> > > +
> > > +	/* Already enabled? */
> > > +	if (mm->context.lam_cr3_mask)
> > > +		return -EBUSY;
> > > +
> > > +	/* LAM has to be enabled before spawning threads */
> > > +	if (get_nr_threads(current) > 1)
> > > +		return -EBUSY;
> > 
> > This will not be sufficient in general. You can have mm shared with a
> > process without CLONE_THREAD. So you would also need to check also
> > MMF_MULTIPROCESS. But I do remember that general get_nr_threads is quite
> > tricky to use properly. Make sure to CC Oleg Nesterov for more details.
> > 
> > Also how does this work when the mm is shared with a kernel thread?
> 
> It seems we need to check mm_count to exclude kernel threads that use the
> mm. But I expect it to produce bunch of false-positives.
> 
> Or we can make all CPUs to do
> 
> 	switch_mm(current->mm, current->mm, current);
> 
> and get LAM bits updated regardless what mm it runs. It would also remove
> limitation that LAM can only be enabled when there's no threads.
> 
> But I feel that is a bad idea, but I have no clue why. :P

Below is what I meant. Maybe it's not that bad. I donno.

Any opinions?

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 56822d313b96..69e6b11efa62 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -752,6 +752,16 @@ static bool lam_u48_allowed(void)
 	return find_vma(mm, DEFAULT_MAP_WINDOW) == NULL;
 }
 
+static void enable_lam_func(void *mm)
+{
+	struct mm_struct *loaded_mm = this_cpu_read(cpu_tlbstate.loaded_mm);
+
+	if (loaded_mm != mm)
+		return;
+
+	switch_mm(loaded_mm, loaded_mm, current);
+}
+
 static int prctl_enable_tagged_addr(unsigned long nr_bits)
 {
 	struct mm_struct *mm = current->mm;
@@ -760,10 +770,6 @@ static int prctl_enable_tagged_addr(unsigned long nr_bits)
 	if (mm->context.lam_cr3_mask)
 		return -EBUSY;
 
-	/* LAM has to be enabled before spawning threads */
-	if (get_nr_threads(current) > 1)
-		return -EBUSY;
-
 	if (!nr_bits) {
 		return -EINVAL;
 	} else if (nr_bits <= 6) {
@@ -785,8 +791,8 @@ static int prctl_enable_tagged_addr(unsigned long nr_bits)
 		return -EINVAL;
 	}
 
-	/* Update CR3 to get LAM active */
-	switch_mm(current->mm, current->mm, current);
+	on_each_cpu_mask(mm_cpumask(mm), enable_lam_func, mm, true);
+
 	return 0;
 }
 
-- 
 Kirill A. Shutemov
