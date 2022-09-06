Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2ABE5AF0DB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbiIFQo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238547AbiIFQnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:43:46 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7F251A38
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 09:22:45 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-127a3a39131so8618141fac.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 09:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=A4brQTvRlh4R5wPRp39SU02kPOk/lBeJHkJkNAOJzuE=;
        b=isU9HDA1TFgFaIT1MAKrgwCsm+L+E2hAnFW3gXsCwQzf7nTHo/+zRFgKPs9wrf4qbA
         1qf0eRE0B14dUZzgGu76iRnh8ybluQPmWi4sVXsx4cQVy+ZOc27LG/5Px+vewz7Kkz+v
         6TFJ/SJ4CBKioqBXywGAptxXvfgWc009plbGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=A4brQTvRlh4R5wPRp39SU02kPOk/lBeJHkJkNAOJzuE=;
        b=62y4/LUM6eUC6a2grznLL4vqf3QH5RHyVTZ6eevYGaKeGmyb29mipLWjRhVbohQvz8
         T/JblaiSZOZyo+Yj5siJ0qWYGutWdz+yx/49wHNyqQzfM0xzO/YUu3GgXYDQd4wfHnh2
         UOWtCTnuDrlziQHkGi7UC/DhWfI4ha4vYAgFS3QwYdlQSLInCGZQEqSZ4wGuqWYI/WYZ
         HYEoDT7EquJQeU5wbm+zA2zxOdLezSxP1iAqctQRXZF3FD+x2s0GzFCkS7rW0QcZMNbh
         INPTW36xFVD1vGn1G8e7pcDNGN0tRVUia0jljRqFwFpgOD7y2gWBx+Ed4USYkb65mO96
         TP2w==
X-Gm-Message-State: ACgBeo0OF81mR7oXw1rjMQVSUWhjzU09jdUZxOA5OO8/ACY/lBLAgzGG
        d9ER6Esa2lnvrajNunGR0J0utYuFED2x6Q==
X-Google-Smtp-Source: AA6agR74m7vvk4Vbs3xFd00CBez1WfnR6wLcTJ2APWEQD4I0blxqfL0goEVz+uZxIFTLimzDMLaQyQ==
X-Received: by 2002:a05:6808:3021:b0:335:182f:a66a with SMTP id ay33-20020a056808302100b00335182fa66amr10322057oib.295.1662481364363;
        Tue, 06 Sep 2022 09:22:44 -0700 (PDT)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com. [209.85.160.46])
        by smtp.gmail.com with ESMTPSA id m12-20020a056870058c00b001274845032dsm3405695oap.13.2022.09.06.09.22.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 09:22:43 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1274ec87ad5so14524575fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 09:22:43 -0700 (PDT)
X-Received: by 2002:a05:6808:3096:b0:342:ff93:4672 with SMTP id
 bl22-20020a056808309600b00342ff934672mr10837507oib.174.1662481362737; Tue, 06
 Sep 2022 09:22:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220112211258.21115-1-chang.seok.bae@intel.com>
 <20220112211258.21115-8-chang.seok.bae@intel.com> <CAE=gft4P2iGJDiYJccZFR1VnNomQB7Uo522r2gvrfNY9oKz5jg@mail.gmail.com>
 <763bddd2-2fc3-a857-0dff-a5ae4ae1f298@intel.com> <CAE=gft5VajfoAT6hVxiCzAMYiDV+pHRbC-F7s4+qK94qa0og5w@mail.gmail.com>
 <6f2dcc0c-99a2-8698-13ae-d5cbea9945b0@intel.com> <CAE=gft6sO85RBpfdXnR=_r=KGmVrx0mnBOHK7XadNk00gDr-WA@mail.gmail.com>
 <a3fd8d2d-72d0-ba13-ef77-caff2b239867@intel.com>
In-Reply-To: <a3fd8d2d-72d0-ba13-ef77-caff2b239867@intel.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 6 Sep 2022 09:22:06 -0700
X-Gmail-Original-Message-ID: <CAE=gft7BQAwHTxoCtSu-gHZDtcETvBM-nony_nzBD8ziE_HcZw@mail.gmail.com>
Message-ID: <CAE=gft7BQAwHTxoCtSu-gHZDtcETvBM-nony_nzBD8ziE_HcZw@mail.gmail.com>
Subject: Re: [PATCH v5 07/12] x86/cpu/keylocker: Load an internal wrapping key
 at boot-time
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     linux-crypto@vger.kernel.org, dm-devel@redhat.com,
        herbert@gondor.apana.org.au, Eric Biggers <ebiggers@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        luto@kernel.org, Thomas Gleixner <tglx@linutronix.de>, bp@suse.de,
        dave.hansen@linux.intel.com, mingo@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        charishma1.gairuboyina@intel.com, kumar.n.dwarakanath@intel.com,
        ravi.v.shankar@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 4:16 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> On 8/25/2022 8:31 AM, Evan Green wrote:
> >
> > Here's the log I've got that pointed me down this path:
> > https://pastebin.com/VvR1EHvE
>
>      <3>[43486.261583] x86/keylocker: The key backup access failed with
> read error.
>      <3>[43486.261584] x86/keylocker: Failed to restore internal
> wrapping key.
>
> Looks like the IWKey backup was corrupted on that system.
>
> > Relevant bit pasted below:
> >
> > <6>[43486.263035] Enabling non-boot CPUs ...
> > <6>[43486.263081] x86: Booting SMP configuration:
> > <6>[43486.263082] smpboot: Booting Node 0 Processor 1 APIC 0x1
> > <2>[43486.264010] kernel tried to execute NX-protected page - exploit
> > attempt? (uid: 0)
> > <1>[43486.264019] BUG: unable to handle page fault for address: ffffffff94b483a6
> > <1>[43486.264021] #PF: supervisor instruction fetch in kernel mode
> > <1>[43486.264023] #PF: error_code(0x0011) - permissions violation
> > <6>[43486.264025] PGD 391c0e067 P4D 391c0e067 PUD 391c0f063 PMD
> > 10006c063 PTE 8000000392148163
> > <4>[43486.264031] Oops: 0011 [#1] PREEMPT SMP NOPTI
> > <4>[43486.264035] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G U
> > 5.10.136-19391-gadfe4d4b8c04 #1
> > b640352a7a0e5f1522aed724296ad63f90c007df
> > <4>[43486.264036] Hardware name: Google Primus/Primus, BIOS
> > Google_Primus.14505.145.0 06/23/2022
> > <4>[43486.264042] RIP: 0010:load_keylocker+0x0/0x7f
>
> But, I don't get the reason why it hit this. On the wake-up path,
> copy_keylocker() is supposed to be called.

Interesting, that's helpful. I thought I had a lead based on this,
which was that in this case we were doing a hibernate to shutdown,
rather than hibernate to S4. The IWKey backup is only valid down to
S4, so a read error on resume from this type of hibernate might make
sense. I know keylocker won't successfully maintain handles across a
hibernate to shutdown and subsequent resume, but it shouldn't crash
either.

But this still doesn't explain this crash, since in this case we're
still on our way down and haven't even done the shutdown yet. We can
see the "PM: hibernation: Image created (1536412 pages copied)" log
line just before the keylocker read failure. So then it seems
something's not working with the pre-hibernate CPU hotplug path?


>
> I added some printout in there, and it looks to be fine with me:
>
>      [  218.488711] Enabling non-boot CPUs ...
>      [  218.488794] x86: Booting SMP configuration:
>      [  218.488795] smpboot: Booting Node 0 Processor 1 APIC 0x1
>      [  218.490634] x86/keylocker: restore processor (id=1)
>      [  218.491186] CPU1 is up
>      ...

How were you exercising the CPU onlining in this case? Boot, cpu
hotplug, or hibernate?
-Evan
