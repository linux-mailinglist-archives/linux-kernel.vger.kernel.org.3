Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E5D5391C9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 15:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344600AbiEaNYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 09:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236113AbiEaNYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 09:24:46 -0400
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6855462A2F
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 06:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654003477;
        bh=VAysqpypj8lgtjmNvnE6i4S+p+KwnwkxLOL/g3kOSZw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=VFTvO5Q8V3M376SLyB36qGc5EBBspXseif/5AkUs43jQ0G6plR9w1LOAK1lHbBv2v
         Uc5TXq7uIn+dkoxUXIFz0m1neJyLladvN0IegeYV9U9b8N7ZErkK3dhQPF/VmnlHGR
         Mixg6GDZRALt8cCJGff5DURFBMbMZHBsYjrjYUt0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [100.120.147.234] ([84.17.52.175]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MIdeR-1nzcES0Ve9-00EfRh; Tue, 31
 May 2022 15:24:37 +0200
Message-ID: <ba006409-2054-fe83-2b62-996d89f527f9@gmx.fr>
Date:   Tue, 31 May 2022 15:24:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: PROBLEM: with daemon.c after y2038 on 32-bits Kernel
Content-Language: en-US
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>, y2038@lists.linaro.org,
        libc-alpha@sourceware.org, linux-kernel@vger.kernel.org
References: <CAK8P3a0bmE03wJ_iELrAMyFvamwd_r5aLsFBH=6=5YaueO=-kg@mail.gmail.com>
 <CAK8P3a3m5E2-w4sewEnb4WK68T1wduChR6eSUzsaWPicYhKPHQ@mail.gmail.com>
 <4b83ea18-e106-e7ec-d1d9-daa74aeaf990@linaro.org>
 <cbde441f-b172-2a01-606d-0f97681a59fb@gmx.fr> <YpYR6E9MWJObVtN6@arm.com>
From:   =?UTF-8?Q?Arnaud_Pana=c3=afotis?= <arnaud.panaiotis@gmx.fr>
In-Reply-To: <YpYR6E9MWJObVtN6@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Antivirus: Avast (VPS 220531-2, 31/5/2022), Outbound message
X-Antivirus-Status: Clean
X-Provags-ID: V03:K1:OXiv5Ofe7WJMq9bAohX5C1VNgstjS1X2ohrsSvEp3JnDrJY3SI4
 i6Mz3FrwYte1ToskxkXbmu5T+iKlShnnUnda7BKHxnniqtft+fxAAHoau5rQ5e/qaUQOZPU
 o2MyETREern8PmfroIWc9q29xDIcEOMagIycWV0tCFtkmqF5Ge+oK5Lpdq46GFYks5svFTu
 BWuddP1uazAbec08tw9QA==
X-UI-Out-Filterresults: junk:10;V03:K0:+1qdnhNeemg=:Mt0Nfm/a0zy0DLHrFAn9Digg
 67Gf/8sjtovyePmipMZw8SAkGBtfm+S4mYfDewFTv5LK3c6mYDlY5IHlrVQ3ROYyEWCsA8nki
 pteI1FQw6nXN8N4c/e5b1EXQqrU2VlJbEjfIN/RL7chns5IOil5c45992nJyNM/MHtz5i7o1a
 nS/iPWNHbm3mY6XZQ54Ws1Er1XhjqJaxNpSRTh0RrHyusu6EeYS17AmDyrBhVYhGW3FkQ+24o
 ofh8/S9/7mzVIA7/Use7PqHEqgo7+lW95u92eMRueMGFFUsgIUHDY/qeEqTx2VuPVvdJ8IQBM
 uuGjaIEXczxOoB+aEX1U46PUCrU4a7GRwcX5JY8W45KF2OG8O2eLcmMRErRSej9qBI+0EDU6V
 bkXiUGFF6Px8GnXrLjrmP1dFVI1qAoQSxBjqdIJ4zTdw0sGvkxsFubgOq+Q4cotLPtMrb1oDz
 gF89UafT0VGmg3sYcH6+vR0Ymhnogb9iNuN0CiirnnXUzh/188729zMiVBn4ff5i1xxgG4DUD
 CQBhhUo3VyuXrgBnG2Max0gpLun/vUs0KJPbTPDDJhU/ODZ7HLQwD0rJ3cD9tnKI6iHkArezU
 pp3hm2lbpWPmJHjk2r4CY4bdggQK5XhlcFp1Vm9VSnVY7GVC9rJc2xMkuooz7of4w5JToL7y8
 D96BVn9EVw50szSeveMi9/UZyv9+MLBnLrvvFza+NDYeFBuhXdyjt7m6trUJUuKfOuyTzUvAU
 cBzt+3cNsUPK+n7m0QRpSEi/EF9Leh/qKEaM9VKh4mxMICxixF7xpecuRY5McwyO0kiIDKRae
 ohBzemIXn2VtzrSsF1DRHS+SlyHScyv2zM9EEpUNvfig+tmprvU7rKutEkzcmpclU+PaqV6+b
 gXmlneLgxgmhyoW4QWYh7y/TIehAoMTVDEoEOUyTi8lnisE/vXI6eAGhNH8HNxpDLAveXIY5P
 yg5AK+qDSdQuiMAO2Rv70yGSvcFYKE46ruGpEgqO3VH4uRU7xBGubTk7itd8+26oqVBaj2clf
 hefeR42E26o0YZCKmNgTVa0FXQlkz/mmVx6DGuRItpJoiP32v2O6NGh+6I2tJ3/Xvatx9Uqze
 Rs6AunGZfjOtq8pnq/XpRXaYwIW1qqVylLHwlIahk4gB4hC+ylBlNRC0ZhcaLlDICXpiALJxO
 ZU1hxKAlOOpQBhDJk+dh+5tJ
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 31/05/2022 15:02, Szabolcs Nagy wrote:
> The 05/31/2022 14:16, Arnaud Pana=C3=AFotis via Libc-alpha wrote:
>>>>> If I'm reading this correctly, daemon() internally uses the time32
>>>>> version of 'stat', which fails for files with out-of-range timestamp=
s.
>>>>> Are you able to rebuild the ssh binary (or your entire distro, if th=
at's
>>>>> easier) against musl-1.2.x instead of glibc to see if the same thing
>>>>> happens there?
>> Musl did not worked previously for me, not sure for openssh only within
>> Buildroot.
> did you have a specific issue with musl?
>
> it is supposed to work with buildroot and
> has 64bit time_t support out of the box.

Not really, I'm working on an existing project that was developed before
with Glibc. If I remember correctly some packages used by the project
did not build with musl (even with the previous version of Kernel).

The purpose of my mission was to analyze how to pass y2038 on embedded
devices (2 Linux and 1 Windows), now is to build the solution.

Upgrading Glibc and Buildroot were easier than switching to musl due
what was done before. I probably would have to change many elements
(packages, init scripts...) if I'd switched to musl.

Now both y2038 Linux works with glibc, this subject is the third I
raised (mysqld solved by a patch I made, cp binutils with issue from
fchmodat (bug 29097)).


=2D-
L'absence de virus dans ce courrier =C3=A9lectronique a =C3=A9t=C3=A9 v=C3=
=A9rifi=C3=A9e par le logiciel antivirus Avast.
https://www.avast.com/antivirus

