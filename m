Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F7258EA65
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 12:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiHJKXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 06:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiHJKXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 06:23:00 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151CC56B9D
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 03:22:59 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id gb36so26813984ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 03:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc;
        bh=sI8ZZBr1JuNoiGQh9KrzRGcAQTatYvynl+4y+qL068k=;
        b=mmAfA8A0WBR4nMz9DKK7BUqcR2s5XjFTI3lL0Oqc1H0/wVZ6D3mOfq3Fm78hequ3uS
         TmVvjAsqNfTCo3ArhNxxUU+RX/TBYOQXsjURCzsMX0Dz9JckVQkpyEgIraeIDBzNYnhs
         +4esj0KvEgNPJ4Fr6tE4dAmFnwjMOcC8bPn9wnXjQ9vY7GACVrprD/lsQNN5dNuwqAIf
         EkYDHxwxWohJiAmNXgVrR5wKUeP7plNkAIACk4X/doKOelbX6Mrt60+Ei4eUadFYoABW
         Dfc5R9j12cjLIuB5wSVMJFXU2+qhbo1Doe2othtpJHjxOreoAaG0h1tyOThCfrQMxJFL
         SpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc;
        bh=sI8ZZBr1JuNoiGQh9KrzRGcAQTatYvynl+4y+qL068k=;
        b=N34+F5ChRxoEsjOuxCuZScQU89RIcSDO2oaP4WKtqPYbml7r1df/5a7h02ekCh1qZh
         z9ehaIK/crezs0IjLT8S1qt9xZEndroNeeuoHuEhHGlUxW73uc/aNXUSIOspz5/wOns5
         Bh2V0uYpnmYb20FPpMx+BZk0n8gfLPynknhXSddIkRnSPipm8JJFn2iGZAp7eNZdEPh4
         imTIXqxdyy6BBm8WvJVeJ0/K7DNMPe7AaZlUfm2gVqdb7a0OyFYVlDfqqXyN8jzGyF9B
         Wx+unYPNpT6qQRvmvj07a4u10zTsdaCAw7ZSoZSoDkQqQXO60a4uueyX7qO4EM5ccZcn
         2x4Q==
X-Gm-Message-State: ACgBeo2Qsj8EXKXnBWkLZmGNHK9Vw0UVmKs0JqOj+kfUzBG3fg7kqtF0
        kPGeWCsqHDsfqlkhveqWdNf78g==
X-Google-Smtp-Source: AA6agR61pmFrc+/6dzRSTmnWlyispHL7maEVDC61kJQ1n13aNi4qab1EsNKshRSyze06UpNcdqPiFQ==
X-Received: by 2002:a17:906:845c:b0:730:bbf1:196a with SMTP id e28-20020a170906845c00b00730bbf1196amr19895946ejy.13.1660126977530;
        Wed, 10 Aug 2022 03:22:57 -0700 (PDT)
Received: from mbp-di-paolo.station (net-93-70-86-43.cust.vodafonedsl.it. [93.70.86.43])
        by smtp.gmail.com with ESMTPSA id f12-20020a17090631cc00b0072ee9790894sm2129835ejf.197.2022.08.10.03.22.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Aug 2022 03:22:56 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator
 drives
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <SJ0PR20MB44093D6FB740E543EDAAC002A0629@SJ0PR20MB4409.namprd20.prod.outlook.com>
Date:   Wed, 10 Aug 2022 12:22:55 +0200
Cc:     Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Muhammad Ahmad <muhammad.ahmad@seagate.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        "andrea.righi@canonical.com" <andrea.righi@canonical.com>,
        "glen.valante@linaro.org" <glen.valante@linaro.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Tyler Erickson <tyler.erickson@seagate.com>,
        Michael English <michael.english@seagate.com>,
        Andrew Ring <andrew.ring@seagate.com>,
        Varun Boddu <varunreddy.boddu@seagate.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <74F8D5E8-0D56-413B-A3CA-7462D9C862D6@linaro.org>
References: <20220623155335.6147-1-paolo.valente@linaro.org>
 <PH7PR20MB505849512979A89E8A66FB24F18E9@PH7PR20MB5058.namprd20.prod.outlook.com>
 <SJ0PR20MB44093D6FB740E543EDAAC002A0629@SJ0PR20MB4409.namprd20.prod.outlook.com>
To:     Rory Chen <rory.c.chen@seagate.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 9 ago 2022, alle ore 05:47, Rory Chen =
<rory.c.chen@seagate.com> ha scritto:
>=20
> Resend the mail as plain text because previous mail with rich text =
makes some mess and forget to add others at Seagate who worked on =
validating the
> patch as well(Muhammad, Michael, Andrew, Varun,Tyler)
>=20
> Hi Paolo,
>=20

Hi

> I am from Seagate China and face a problem when I=E2=80=99m evaluating =
the bfq patches. Could you please check?
> Thanks
>=20
> Issue statement
> When running performance test on bfq patch, I observed warning message =
"bfq_actuator_index: bio sector out of ranges: end=3D35156656128" and OS =
hung suddenly after some hours.
> The warning message is reported from function bfq_actuator_index which =
determines IO request is in which index of actuators.  The =
bio_end_sector is 35156656128 but the max LBA for the drive is =
35156656127 so it=E2=80=99s beyond the LBA range.

Yep, this sanity check fails if the end sector of a new IO does not
belong to any sector range.

>  I captured the block trace and didn=E2=80=99t found request LBA =
35156656128 instead only found max request LBA 35156656127.

Maybe in the trace you see only start sectors?  The failed check si
performed on end sectors instead.

At any rate, there seems to be an off-by-one error in the value(s)
stored in the sector field(s) of the blk_independent_access_range data
structure.

I guess we may need some help/feedback from people competent on this
stuff.

> I=E2=80=99m not sure if this warning message is related to later OS =
hung.
>=20

Not easy to say.  At any rate, we can try with a development version
of bfq.  It can help us detect the possible cause of this hang.  But
let's see where we get with this sector error first.

Thank you for testing this extended version of bfq,
Paolo

>=20
> Problem environment
> Kernel base is 5.18.9
> Test HDD drive is Seagate ST18000NM0092 dual actuator SATA.
> Actuator LBA mapping by reading VPD B9
> Concurrent positioning ranges VPD page:
> LBA range number:0
> number of storage elements:1
> starting LBA:0x0
> number of LBAs:0x417c00000 [17578328064]
> LBA range number:1
> number of storage elements:1
> starting LBA:0x417c00000
> number of LBAs:0x417c00000 [17578328064]
>=20
>=20
>=20
>=20
>=20
> From: Paolo Valente <paolo.valente@linaro.org>
> Sent: Thursday, June 23, 2022 8:53 AM
> To: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org <linux-block@vger.kernel.org>; =
linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; =
jack@suse.cz <jack@suse.cz>; andrea.righi@canonical.com =
<andrea.righi@canonical.com>; glen.valante@linaro.org =
<glen.valante@linaro.org>; Arie van der Hoeven =
<arie.vanderhoeven@seagate.com>; Paolo Valente =
<paolo.valente@linaro.org>
> Subject: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator =
drives
>=20
>=20
> This message has originated from an External Source. Please use proper =
judgment and caution when opening attachments, clicking links, or =
responding to this email.
>=20
>=20
> Hi,
> this patch series extends BFQ so as to optimize I/O dispatch to
> multi-actuator drives. In particular, this extension addresses the
> following issue. Multi-actuator drives appear as a single device to
> the I/O subsystem [1].  Yet they address commands to different
> actuators internally, as a function of Logical Block Addressing
> (LBAs). A given sector is reachable by only one of the actuators. For
> example, Seagate=E2=80=99s Serial Advanced Technology Attachment =
(SATA)
> version contains two actuators and maps the lower half of the SATA LBA
> space to the lower actuator and the upper half to the upper actuator.
>=20
> Evidently, to fully utilize actuators, no actuator must be left idle
> or underutilized while there is pending I/O for it. To reach this
> goal, the block layer must somehow control the load of each actuator
> individually. This series enriches BFQ with such a per-actuator
> control, as a first step. Then it also adds a simple mechanism for
> guaranteeing that actuators with pending I/O are never left idle.
>=20
> See [1] for a more detailed overview of the problem and of the
> solutions implemented in this patch series. There you will also find
> some preliminary performance results.
>=20
> Thanks,
> Paolo
>=20
> [1] =
https://secure-web.cisco.com/1hcxnN1C3h1nW7mby7S66_LE8szirQwbQI0fBpYePrA0G=
TWfyuQyl0GpZaOn32xMSkNT0BUQWloDHFzZ23aYDZdi8NfdrEFLY9pQDBblIvn08LRiTVoIOUC=
8zWSG_r2PCyLtx3ppZq5cWOib_8azxteRRcbKWGdbLPSqg9hfSJSqltth0ByLONHEoI3p3e9QN=
In6nVAeQbsT3aOQe-F95XrQvaPrFJXx6RGL9kDXyfkbXIHcdcLBf895gYBFn5S2WjBDQq2kzDz=
ZOlc1HekRUhg0qDQcFY6NydVfrqNfLbpAHAth6KyREscQhVTMVREEVa1b6bQByX6grF5pn3pTI=
o0lODyfX6yRmcbReSYNfOZ65ZPvp-nH530FQ-5nXoRxFf74WIKDrNTALs3xQvg03DH4jLez-T2=
M9xEu-sfEDAEdTGF7BcnmBW6vrPO4_p3k4/https%3A%2F%2Fwww.linaro.org%2Fblog%2Fb=
udget-fair-queueing-bfq-linux-io-scheduler-optimizations-for-multi-actuato=
r-sata-hard-drives%2F
>=20
> Davide Zini (3):
>  block, bfq: split also async bfq_queues on a per-actuator basis
>  block, bfq: inject I/O to underutilized actuators
>  block, bfq: balance I/O injection among underutilized actuators
>=20
> Federico Gavioli (1):
>  block, bfq: retrieve independent access ranges from request queue
>=20
> Paolo Valente (4):
>  block, bfq: split sync bfq_queues on a per-actuator basis
>  block, bfq: forbid stable merging of queues associated with different
>    actuators
>  block, bfq: turn scalar fields into arrays in bfq_io_cq
>  block, bfq: turn BFQ_NUM_ACTUATORS into BFQ_MAX_ACTUATORS
>=20
> block/bfq-cgroup.c  |  97 +++++----
> block/bfq-iosched.c | 488 +++++++++++++++++++++++++++++---------------
> block/bfq-iosched.h | 149 ++++++++++----
> block/bfq-wf2q.c    |   2 +-
> 4 files changed, 493 insertions(+), 243 deletions(-)
>=20
> --
> 2.20.1
>=20
>=20
> Seagate Internal
>=20
> Seagate Internal

