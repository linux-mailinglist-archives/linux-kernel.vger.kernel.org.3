Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A184E8095
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 12:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbiCZLlF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 26 Mar 2022 07:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiCZLlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 07:41:04 -0400
X-Greylist: delayed 96494 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 26 Mar 2022 04:39:27 PDT
Received: from mail.sysgo.com (mail.sysgo.com [159.69.174.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E174E3B5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 04:39:26 -0700 (PDT)
From:   Matthias Welwarsky <matthias.welwarsky@sysgo.com>
To:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86-ml <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: x86, possible bug in __memmove() alternatives patching
Date:   Sat, 26 Mar 2022 12:39:23 +0100
Message-ID: <3346653.QJadu78ljV@linux-3513>
Organization: SYSGO GmbH
In-Reply-To: <d9d0405e-b118-b028-d26f-fbb8de4e7a0e@intel.com>
References: <3422754.iIbC2pHGDl@linux-3513> <Yj49F1pnehy3ga5U@zn.tnic> <d9d0405e-b118-b028-d26f-fbb8de4e7a0e@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Samstag, 26. März 2022 05:45:24 CET Dave Hansen wrote:
> On 3/25/22 15:07, Borislav Petkov wrote:
> > I know it's is probably a very rare case and Intel recommends having fast
> > string ops enabled, hence the question: would this be considered a bug in
> > the kernel that should be fixed? A potential fix could be to clear FSRM
> > together with ERMS depending on IA32_MISC_ENABLE.
> 
> I'd consider it a bug in the hypervisor, personally. ;)

Of course, no doubt about that.

> But, we do try to make the kernel work even the face of funky
> hypervisors that do things that never occur on real hardware.  If a nice
> patch to fix this up showed up, I'd definitely take a look.

The question is whether a sequence like this could be relevant:

0) CPU announces feature FSRM through cpuid
1) BIOS/firmware disables fast string ops through IA32_MISC_ENABLE before 
loading kernel (for whatever reason)
2) Kernel populates features from cpuid
3) Kernel clears ERMS based on IA32_MISC_ENABLE
4) "alternatives" patching destroys __memmove()

That depends on whether a cpuid instruction after step 1) would still announce 
FSRM. If not, then the whole point is moot and no patch needed (unless we want 
to guard against hypervisor bugs).

-- 
Mit freundlichen Grüßen/Best regards,

Matthias Welwarsky
Project Engineer

SYSGO GmbH
Office Mainz
Am Pfaffenstein 8 / D-55270 Klein-Winternheim / Germany
Phone: +49-6136-9948-0 / Fax: +49-6136-9948-10
E-mail: matthias.welwarsky@sysgo.com
_________________________________________________________________________________
Web: https://www.sysgo.com
Blog: https://www.sysgo.com/blog
Events: https://www.sysgo.com/events
Newsletter: https://www.sysgo.com/newsletter
_________________________________________________________________________________
Handelsregister/Commercial Registry: HRB Mainz 90 HRB 48884 
Geschäftsführung/Managing Directors: Etienne Butery (CEO), Kai Sablotny (COO) 
USt-Id-Nr./VAT-Id-No.: DE 149062328 

The protection of your personal data is important to us. Under the following 
link 
you can see the information in accordance with article 13 GDPR: 
https://www.sysgo.com/privacy_policy


