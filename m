Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5395053F359
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 03:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbiFGB0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 21:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235639AbiFGB0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 21:26:46 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67ECD92726
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 18:26:45 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1654565203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3dCWMnb9YQAzGb0TXieFZvIKgtDNPxBfikpEIogljaI=;
        b=Qndyk0evkLYtgy/Qipo2Lvzc3+RyIXPBLLxUZs+6z5VDAH/1q2uH79xQZwYY+jPFIaPU+w
        JuELN0Y331HdGw1YKvDEAv2hTfvJhQNRj4IgJXJ3DLCGb1qEuIKvT55JJkDlNbjLIm0h4B
        ucLAGtp6ULVQTtia/JAvlmZixegqRjc=
Date:   Tue, 07 Jun 2022 01:26:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <32bfd9554e9afcb0f8eaec247e253b3d@linux.dev>
Subject: Re: [PATCH] sched/deadline: Use proc_douintvec_minmax() limit
 minimum value
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20220513024109.648471-1-yajun.deng@linux.dev>
References: <20220513024109.648471-1-yajun.deng@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping.=0A=0A=0A=0AMay 13, 2022 10:41 AM, "Yajun Deng" <yajun.deng@linux.de=
v> wrote:=0A=0A> proc_dointvec() is not applicable for unsigned integer, =
use=0A> proc_douintvec_minmax() limit minimum value.=0A> =0A> Signed-off-=
by: Yajun Deng <yajun.deng@linux.dev>=0A> ---=0A> kernel/sched/deadline.c=
 | 6 ++++--=0A> 1 file changed, 4 insertions(+), 2 deletions(-)=0A> =0A> =
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c=0A> index =
85cd62e0dddd..4d2a780c6f73 100644=0A> --- a/kernel/sched/deadline.c=0A> +=
++ b/kernel/sched/deadline.c=0A> @@ -30,14 +30,16 @@ static struct ctl_ta=
ble sched_dl_sysctls[] =3D {=0A> .data =3D &sysctl_sched_dl_period_max,=
=0A> .maxlen =3D sizeof(unsigned int),=0A> .mode =3D 0644,=0A> - .proc_ha=
ndler =3D proc_dointvec,=0A> + .proc_handler =3D proc_douintvec_minmax,=
=0A> + .extra1 =3D (void *)&sysctl_sched_dl_period_min,=0A> },=0A> {=0A> =
.procname =3D "sched_deadline_period_min_us",=0A> .data =3D &sysctl_sched=
_dl_period_min,=0A> .maxlen =3D sizeof(unsigned int),=0A> .mode =3D 0644,=
=0A> - .proc_handler =3D proc_dointvec,=0A> + .proc_handler =3D proc_doui=
ntvec_minmax,=0A> + .extra2 =3D (void *)&sysctl_sched_dl_period_max,=0A> =
},=0A> {}=0A> };=0A> -- =0A> 2.25.1
