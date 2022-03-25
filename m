Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35F94E7B67
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbiCYWJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 18:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbiCYWJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 18:09:06 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84E5162186
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 15:07:29 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1ED7C1EC0629;
        Fri, 25 Mar 2022 23:07:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1648246044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=03FkH3b1V3rYZ76Xkrc6M+MeiwD9LyYLh0ixfZD/69s=;
        b=OGQT/twTtZ5FWSdr6TFuArHt49z6ADioSXHqbpadhmeFtXIiQIOaU400fOeKSaAZbQpMe7
        55Ip59+OskMeWpVCLnwGf2k8xMXaRo+e07BZbFDXd1lGuB1yLZXNIuv7OaB4JKPF+1E+vQ
        0wuwKOxbfSpxy/Ui5LNyx0A9B2f7e78=
Date:   Fri, 25 Mar 2022 23:07:19 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Matthias Welwarsky <matthias.welwarsky@sysgo.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86-ml <x86@kernel.org>
Subject: Re: x86, possible bug in __memmove() alternatives patching
Message-ID: <Yj49F1pnehy3ga5U@zn.tnic>
References: <3422754.iIbC2pHGDl@linux-3513>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3422754.iIbC2pHGDl@linux-3513>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ dhansen for comment on...

On Fri, Mar 25, 2022 at 09:51:09AM +0100, Matthias Welwarsky wrote:
> Hi list,
> 
> I've come across an odd behavior that I'm not sure whether it counts as a bug.
> I'm working on an x86 hypervisor at the moment and there was an odd problem 
> with a linux guest system dying during booting, but only on an intel NUC11 
> (i3-1115G4). It booted normally on any other system I tested on.
> 
> The guest was usin kernel version 5.10.89.
> 
> Now, the reason eventually turned out to be __memmove() getting broken when 
> applying the alternatives. The CPU on the NUC11 has the FSRM feature, which 
> enables a particular alternative in __memmove(). However, the code assumes 
> that the ERMS feature is always present with FSRM, otherwise the function gets 
> broken. Of course this is normally the case, a CPU without ERMS would never 
> advertise FSRM.
> 
> However: in the function early_intel_setup(), the ERMS feature might get 
> cleared depending on the IA32_MISC_ENABLE MSR: if fast string operations are 
> disabled through this MSR, X86_FEATURE_ERMS is removed from the available set, 
> but X86_FEATURE_FSRM is not removed.

... this thing, whether that's really the case on real hw.

Leaving in the rest for reference.

> Now, the hypervisor I'm working on emulates this MSR and in the particular 
> case, fast string ops were reported as disabled, leading to the above 
> mentioned inconsistency in __memmove().
> 
> The Intel SDM doesn't go into any details if disabling fast string ops through 
> IA32_MISC_ENABLE will also clear FSRM from cpuid leaf 7, but I think that's 
> not relevant for the linux kernel anyway because cpuid is parsed before MSRs 
> are evaluated.
> 
> I know it's is probably a very rare case and Intel recommends having fast 
> string ops enabled, hence the question: would this be considered a bug in the 
> kernel that should be fixed? A potential fix could be to clear FSRM together 
> with ERMS depending on IA32_MISC_ENABLE.
> 
> 
> Mit freundlichen Grüßen/Best regards,
> 
> Matthias Welwarsky
> Project Engineer
> 
> SYSGO GmbH
> Office Mainz
> Am Pfaffenstein 8 / D-55270 Klein-Winternheim / Germany
> Phone: +49-6136-9948-0 / Fax: +49-6136-9948-10
> E-mail: matthias.welwarsky@sysgo.com
> _________________________________________________________________________________
> Web: https://www.sysgo.com
> Blog: https://www.sysgo.com/blog
> Events: https://www.sysgo.com/events
> Newsletter: https://www.sysgo.com/newsletter
> _________________________________________________________________________________
> Handelsregister/Commercial Registry: HRB Mainz 90 HRB 48884 
> Geschäftsführung/Managing Directors: Etienne Butery (CEO), Kai Sablotny (COO) 
> USt-Id-Nr./VAT-Id-No.: DE 149062328 
> 
> The protection of your personal data is important to us. Under the following 
> link 
> you can see the information in accordance with article 13 GDPR: 
> https://www.sysgo.com/privacy_policy
> 
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
