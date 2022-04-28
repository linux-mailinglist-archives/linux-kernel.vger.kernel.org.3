Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB5D512ACB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 07:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242852AbiD1FNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 01:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242278AbiD1FNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 01:13:37 -0400
X-Greylist: delayed 2621 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 27 Apr 2022 22:10:22 PDT
Received: from mx0a-0016e101.pphosted.com (mx0a-0016e101.pphosted.com [148.163.145.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945395FF14
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 22:10:20 -0700 (PDT)
Received: from pps.filterd (m0151355.ppops.net [127.0.0.1])
        by mx0a-0016e101.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23S4NENq012008
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 21:26:39 -0700
Received: from act-bufferout-a1.ucsd.edu (act-bufferout-a1.ucsd.edu [132.239.249.20])
        by mx0a-0016e101.pphosted.com (PPS) with ESMTPS id 3fprrgxthk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 21:26:38 -0700
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: nheninger@ad.ucsd.edu)
        by act-bufferout-a1.ucsd.edu (Postfix) with ESMTPSA id 3EAFDCAB18
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 21:26:38 -0700 (PDT)
Received: by mail-vk1-f175.google.com with SMTP id s68so1798738vke.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 21:26:38 -0700 (PDT)
X-Gm-Message-State: AOAM530wbL6aURS9V4g1EpCaEnWTmjzqGVHuuTyaqVX2XyQpVbRHsYbT
        pEXI3RqNB50NclitKTEALdUNje1Us3wUPZ5jUGKF7A==
X-Google-Smtp-Source: ABdhPJzveMv0p0Y+1gLzJ3dB2GoiBswVMb204cFjM80V3omGswtFh65cHuzmG1383YD+bGOuqnRSijXI0cvokVUW/gM=
X-Received: by 2002:a05:6122:200f:b0:34e:499:125f with SMTP id
 l15-20020a056122200f00b0034e0499125fmr2065414vkd.26.1651119997283; Wed, 27
 Apr 2022 21:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <YmlMGx6+uigkGiZ0@zx2c4.com>
In-Reply-To: <YmlMGx6+uigkGiZ0@zx2c4.com>
From:   Nadia Heninger <nadiah@cs.ucsd.edu>
Date:   Wed, 27 Apr 2022 21:26:05 -0700
X-Gmail-Original-Message-ID: <CAEJZX-LvQci9en7bU7Z-ymRJoL=GQsHqTCud3ifgHQRuZ87VAg@mail.gmail.com>
Message-ID: <CAEJZX-LvQci9en7bU7Z-ymRJoL=GQsHqTCud3ifgHQRuZ87VAg@mail.gmail.com>
Subject: Re: is "premature next" a real world rng concern, or just an academic exercise?
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     noahsd@gmail.com, dodis@cs.nyu.edu, tessaro@cs.washington.edu,
        torvalds@linux-foundation.org, djb@cr.yp.to, tytso@mit.edu,
        jeanphilippe.aumasson@gmail.com, jann@thejh.net,
        keescook@chromium.org, gregkh@linuxfoundation.org,
        peter@cryptojedi.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-ORIG-GUID: bhjF3efLXgcwpc9drNfavALCDrM3thF_
X-Proofpoint-GUID: bhjF3efLXgcwpc9drNfavALCDrM3thF_
pp_allow_relay: proofpoint_allowed
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-27_04,2022-04-27_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204280026
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason and others,

(Resending as plain text, I hope.)

I expressed my opinion on this to Jason at RWC but I'll summarize
here: from my perspective, entropy should be added to the pool without
waiting, because giving output from an unseeded pool is worse than
giving output from a poorly seeded pool or the hypothetical risk of
the "premature next" attack scenario Jason outlines.

Concretely, the kind of feasible exploits I can imagine resulting in a
state compromise would be some kind of side-channel attack: spectre or
other MDS attacks, maybe something involving SGX, maybe a plain cache
attack. Here's an example: https://eprint.iacr.org/2019/996.pdf

For the purposes of an academic proof of concept targeting
cryptographic network protocols, the attack sequence would be 1.
attacker compromises state with a side-channel attack 2. attacker
observes nonces in network traffic to track state 3. attacker uses
state to compromise some valuable secret.  In this order of events, it
would be unfortunate if only a small amount of entropy trickled in
between steps 1 and 2 and between 2 and 3 so that the attacker could
brute force the new state, but it would also be unfortunate if no
entropy was added to the pool so that the state compromise required no
brute forcing to reveal the secrets.

Here's an attempt at scaling this attack up to match question #1 that
Jason poses: Attacker exercises a cross-VM side-channel attack to
recover urandom state from a VM serving lots of network requests.
Once the attacker has recovered the state, the attacker observes the
network traffic from the VM.  Each nonce includes a brute-forceable
amount of entropy that allows the attacker to recover the next state,
and then the attacker recovers the secret keys from all the following
network handshakes in sequence.

If the RNG attempts to enforce post-compromise security by pooling
entropy before adding it to the stream, all the traffic sent between
compromise and state update is still recoverable by the attacker.  But
then, Jason's question #3 is valid: in this model, the attacker could
just run their exploit again to recover the new state.

In contrast, an unseeded RNG is much easier to exploit, and we *know*
it has happened in practice, and still happens.

Nadia


On Wed, Apr 27, 2022 at 6:59 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi folks,
>
> The Linux kernel RNG currently pretends to care about the "premature
> next" RNG threat model. I'm wondering whether this is sensible and
> corresponds to anything real.
>
> "Premature next" is the scenario in which:
> - Attacker compromises the current state of a fully initialized RNG with
>   a wild 'n crazy kernel infoleak.
> - New bits of entropy are added directly to the key used to generate the
>   /dev/urandom stream, without any buffering or pooling.
> - Attacker then, somehow having read access to /dev/urandom, samples RNG
>   output and brute forces the individual new bits that were added.
> - Result: the RNG never "recovers" from the initial compromise, a
>   so-called violation of what academics term "post-compromise security".
>
> (Note that this is a different scenario from "premature first", which
> relates to boot-time concerns; this email isn't about "premature
> first".)
>
> There are other varied scenarios to this, usually involving some
> combination of:
> a) Attacker has access to /dev/urandom output continuously or at some
>    interesting interval.
> b) Attacker controls one or more entropy sources providing some subset
>    of varying size of those new bits of entropy.
>
> The Linux kernel currently pretends to mitigate this for scenario (a) at
> least, using "entropy estimation". The idea is that it waits until 256
> estimated "bits" of new entropy are pooled before mixing them into the
> key used to generate the /dev/urandom stream. Never mind the fact that
> entropy estimation is an impossible proposition and thus flawed, it
> certainly does nothing in the way of (b), since there's just one pool.
>
> The NT kernel is a bit more robust, by way of their Fortuna RNG, in
> which there are several pools, and entropy sources round-robin into
> those pools. When it's time to reseed, the first pool is used every
> time, the second pool is used every other time, the third pool is used
> every third time, the forth pool is used every forth time, and so on. In
> theory this should handle both (a) and (b) without needing entropy
> estimation, and this sort of scheduler prompts interesting questions for
> academics with regards to different types of scheduling (a random walk
> instead of round-robin? sounds like a paper topic.) and trying to
> characterize the rate of inputs (continuous? sporadic? modelable?).
>
> While the above "problem" maps pretty clearly to things academics are
> interested in -- post-compromise security for a system with a clear
> model and various creative solutions -- I'm wondering whether any of
> this matters in the real world. From conversations over the last several
> months with various security experts and cryptographers, including those
> who work on the "premature next" problem, the impression I get is that
> nobody actually thinks this matters back on planet Earth, even from
> people who write papers on it.
>
> So the purpose of this email is to solicit feedback on whether anybody
> can think of a plausible scenario in which it does matter. If it does
> matter, the next step will be to determine how much it matters exactly,
> in order for me to gauge the cost-benefit ratio of mitigating the issue
> more robustly in the kernel (e.g. Fortuna requires non-zero code
> complexity; does the benefit outweigh the cost of such complexity?). On
> the other hand, if nobody can think of any reason why this matters, then
> there are some nice improvements that I'm eager to make in a different
> direction.
>
> To review, this attack model concerns:
> - An attacker who compromises the RNG at one point in time via a kernel
>   infoleak.
> - After that infoleak, the attacker somehow no longer has access to the
>   system, but can prevent the RNG from recovering from the compromise by
>   having pretty rapid access to /dev/urandom (and possibly also having
>   compromised zero or more entropy sources).
>
> The questions are thus:
>
> 1) When does an attacker with a kernel infoleak exercise it just once,
>    and then attempt to maintain the leak with some sort of network access
>    to lots of /dev/urandom output (from, e.g., large nonces)?
>
> 2) Or, if it's a local user attacker, when does that attacker infoleak
>    once, but rather than just running the exploit again, cats /dev/urandom
>    continuously?
>
> 3) More broadly speaking, what kernel infoleak is actually acceptable to
>    the degree that anybody would feel okay in the first place about the
>    system continuing to run after it's been compromised?
>
> Looking forward to hearing opinions on this. There's certainly a lot to
> split hairs about above -- incomplete/inaccurate description of the
> "premature next" model, what Fortuna actually achieves, my entropy
> estimation remark, and so forth -- but hopefully this at least throws
> enough things at the board to begin the discussion.
>
> Is "premature next" just an academic exercise, rather than a real world
> RNG concern?
>
> Regards,
> Jason
