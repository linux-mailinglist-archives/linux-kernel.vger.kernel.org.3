Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94872491D38
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 04:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352719AbiARD1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 22:27:38 -0500
Received: from mout.gmx.net ([212.227.15.19]:38321 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358030AbiARDWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 22:22:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642476115;
        bh=5Qq2p5W2JibUj3VnfM9qhlcyuLRttlCtXprUMQmQXP8=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=bj/v7NoGJ48DIogvAZtggMQL5toQPJz4DkBo9Kxx4UI2CIWHhfKmLzE+SC2lopj5o
         exNoWCfAzqUMjq9V8/+V9CthAQsmGeJmYQb3WW0c3vRihbqz/A3z3LRlywRWHgzTx7
         BKZu1tbbL246kOwmQSkURUBuB+a01IS8nfd+ZzYY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.218.34]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MowKi-1mWi9l1fH4-00qQA7; Tue, 18
 Jan 2022 04:21:55 +0100
Message-ID: <0a1c1464e40e4c60687bc715c0b78c9124e456f8.camel@gmx.de>
Subject: Re: regression: LTP isofs testcase failure - bisection fingers
 "loop: make autoclear operation asynchronous"
From:   Mike Galbraith <efault@gmx.de>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     lkml <linux-kernel@vger.kernel.org>
Date:   Tue, 18 Jan 2022 04:21:54 +0100
In-Reply-To: <c53285e4-cbd4-5fd0-cbc9-93e2e3d3d88d@I-love.SAKURA.ne.jp>
References: <4eb771d2b48ee94ba2e3aa8706bce8117d398e80.camel@gmx.de>
         <c53285e4-cbd4-5fd0-cbc9-93e2e3d3d88d@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jPTabahKRVhBNOutTVLWwgUTAD/OU6OXKmHOJNdxhKA+/AHqbCY
 0iAbji0zvSFtTRoscm5OMLXMu+4SGlL8bS45i8c+NuHTDVUscCTqIH562vLAhM6WAGrmNol
 mN4Pid6a/bd038rrM98Ke65Lmn+iS9mRAhY9W9vXi6YwjXpUVJItHBZQsVwcY0m9i7pi344
 shu1+gtNApxxIx3lHNMsA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cUH10lS9UJs=:xqFcs24r5cIenB9Vwbgz1d
 hWf/3LRZ83ZD4DDOCv2yuR0klkm/dJe/K3LZC/WK6A1XcWBK0nviY9ml3Z8wkT55ciSruOZo/
 R4R+rbF/3tca5tu6r95wXzJK6Ar4Ro8ChvY+Vte+f+UgLjUmipRvEyCoMHzNQaFOL+WyhPgne
 LYcGP8tUata7XNbGkro9nWOQ3emmXjsH6QuQGkgtKrvR7YKarDRPZBC3vUFl3nAEqF9OujgCK
 jTn0YuuYs/TEJ0zIi/hqRfsQgnesuvS16DBU0GP5E8nyiZ0N6jiG1ABPn4mxA1zjlVdszLfcx
 UmZ7/JxL7QAwwnvump88SpBpeAGhLR8YzhR0yKU1YBvt6/ASk6kpwRt4cKak6hqee8O3Soq7q
 1XIUcNKv8tZ1zgNTzYxPKOO4HpmRkw5LeFKi9WmGm72/tQdtWZ+NxwJ6Ek48HtkJsQ2cCmW77
 I7jYK6VnaCqOqH0EHJjnssUPfQZ6TnBKP837Z+2hD+W6d8gkmgEC8kOYxsGsKlviWjQpg1wJ3
 xg6ZeL+p+Iq9+71IxAQGrVi9muGyO7dFgOMVj3SfFsWPRTSzvjzfjRLAtnT2avGv5Wrm5d2Gn
 QQUd7qmEas71MkeeSYBs+0V68aPAW9H8dUqYHgwAkvO8Gbz+i4c7C7GMqLjoPc7MT8AaqdiVn
 WdrIFKgw9z1wWx2pTvhVKxIDzeWei3Bv+XRq9XswN9/oc+YI+xOIRk6seeY9NTJDabqm5UyHz
 OmUBxjhT5viN5qeSUzrUhWpyJnMfmexJ7lWtx31OSx65c9tAeHEw+sGMMBWSv1PSmagTiZk0l
 wIxYg9nH2IS/GGUC2J4qvPSVkkA9rviCG0l8a6Okh7hZ8kulSIj9CNJSYP4Z3ye1U20kz4TRm
 F29X6ZY2VpQw9dHj/ml+M9vErG6cn5+HvfpfXGqdItFw24B6XY+jGGFSO6qjsTHTf4PTwAZ0b
 1RzVWQSjSrDdABbUZi9SCe/jCpAQQr/ghjjOOa4wH1OMYTsgDiTdCyxQas2T2PEQZWzFpS1AG
 0RsQqVflnylC7dVcDc+MWVpkr6UxnBixxoZXyDZnTNPpEgCUshKeoSu7+WlsAx17Vg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-01-18 at 06:57 +0900, Tetsuo Handa wrote:
> On 2022/01/18 0:34, Mike Galbraith wrote:
> > Greetings,
> >
> > LTP's isofs testcase began failing this cycle, and bisected as below,
> > which a revert then confirmed.=C2=A0 Full testcase output attached.
> >
>
> Thanks for reporting.
> Discussion is continued at https://lkml.kernel.org/r/cdaf1346-2885-f0da-=
8878-12264bd48348@I-love.SAKURA.ne.jp=C2=A0.

FWIW, simply immediately flushing that shiny new rundown_work turned
LTP's thumb back to upward pointing.

=2D--
 drivers/block/loop.c |    1 +
 1 file changed, 1 insertion(+)

=2D-- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1197,6 +1197,7 @@ static void loop_schedule_rundown(struct
 	kobject_get(&bdev->bd_device.kobj);
 	INIT_WORK(&lo->rundown_work, loop_rundown_workfn);
 	queue_work(system_long_wq, &lo->rundown_work);
+	flush_work(&lo->rundown_work);
 }

 static int loop_clr_fd(struct loop_device *lo)

