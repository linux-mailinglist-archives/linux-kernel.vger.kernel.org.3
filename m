Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7528D475F5B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 18:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhLORbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 12:31:09 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:52521 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237857AbhLORaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 12:30:24 -0500
Received: from Engel05.fritz.box ([84.145.21.134]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M8QNs-1mtAOM258S-004PhP; Wed, 15 Dec 2021 18:30:14 +0100
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de
From:   info@engel-internet.de
Subject: CLOCK_MONOTONIC after suspend
Message-ID: <91eaa528-9605-134e-8e38-ecc37a0360e1@engel-internet.de>
Date:   Wed, 15 Dec 2021 18:30:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:j03kIT4Ogfhps79DPhw2On5cwAjYnaxCJxWL0DfqSySJ0VPeh/T
 fyDRrFXJwSjr0EtbLIqLQ5BUnp7DCMQjI73PxN9yG2eages1aiWouCE4nhOzrWm6PU+Fdfj
 GmzhqylMqOaao/1yykUGxtOJ/3sIKrM/LLsOqY2pEEMSFV68vkt4xl60Jc7ShEwqdDqWn15
 9WSrG48dqaCq8sNE33lOA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+tntscYG1KM=:RNaAIfszy8bhZGe5LCjZh7
 LfMgVnkoHuaplaRNaRDVtfdNcMjdKsWMfWLtqt/fVpVrPppZKPI6F6HI13EjsXfZ/O/QEaoVc
 bEUsnvWxlX1ROi/aH+xO+3MeibheNiguVPlHzbVEDPq5/qAL5Q+bXEZk1B6yVm3OdqR0avCtB
 9WgDmpdwF9RFxTtay+PVJPD5XcvuNh5cC17uY2GCzQr8F0lBi+H1PdsyFJZ5hPay/1HwriVLW
 V5jMG1BvTxbBmHg8LEN3nQnuNNAcdVo5GLz4umO+9ChmW0A2MC4Bkm2Yar9Uc09Zhv3ge0Erp
 mbsLVlEsGZ0uAA6zKAk+V/Ovrjo1LgodHhlLKzVGnevTElxaVbpqYG/4RZ7iOXphRGCM348gP
 +rxkCqIl6jQpJXwuyYtlgtmvvbARr105NbmC0vXT+trMK/ZfQ6iMUHDm55GMS7cz2P9PY8NPC
 GeyLUvT9434VZ1zyudFbmGia7r1TFrPPCCoq/KpfMJMG6E6bd7ahBfsAnhMkfvcdQuxDosDS1
 DmDeWnwK3rqkdcf3TeB6nOAvyALE+6nxny56xCOV6FUr5kbOZPnkDbXGSr/s5lSovGj5889Lv
 DQlGdeHA08Uwpb61NBiaB6mqvevvWWgkFNRuQpbUtg+KWa86jzYcZCfHIx/gf6cBXNCYDXS7j
 VlxHwAlblLQQgSM3ZpIIhyLnKmk0Y7d1P0PXngyOHkoqnFKeN7BsW3C0Mz4bp+YUY+q4QNEgP
 riveYOILbhpotxm3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,



I have a comment/question related to this admittedly quite old commit:

- Revert: Unify CLOCK_MONOTONIC and CLOCK_BOOTTIME,
https://github.com/torvalds/linux/commit/a3ed0e4393d6885b4af7ce84b437dc696490a530#diff-2278494fe0e3426f0e89d14f1f09e5e24923dc29a0f973250081f70416ade7dc



It states "(...) As reported by several folks systemd and other
applications rely on the documented behaviour of CLOCK_MONOTONIC on
Linux and break with the above changes. After resume daemons time out
and other timeout related issues are observed. Rafael compiled this
list: (...)".



From user space perspective similar issues can still be observed. I
guess these ostensible time jumps happen because user space is frozen
before the kernel fell asleep and vice versa on suspend:

dT = (T_KS_asleep – T_US_asleep) + (T_US_awake – T_KS_awake) // T: point
in time, KS: kernel space, US: user space



With a simple user space program that prints out the monotonic time each
100ms along with the day time, I did some measurements on my notebook.
It reveals the following discrepancies (time gaps) between the last time
stamp written before suspend and the first time stamp after resume:



dT in [s]     #1      #2      #3      #4      #5      #6      #7

Suspend2RAM   6.409   6.423   7.451   3.444   7.815   5.655   7.178

Suspend2Disk  5.228   2.683   5.072   5.198   4.806   5.763   6.908



Is this effect known and accepted or is there some way to prevent or
mitigate it?



Thanks,

Dirk

