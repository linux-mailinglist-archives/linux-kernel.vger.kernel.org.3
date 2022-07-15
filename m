Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D565766B0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 20:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiGOSXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 14:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiGOSXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 14:23:34 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349FD60687
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 11:23:34 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:46238)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oCPyP-00GNQO-Az; Fri, 15 Jul 2022 12:23:33 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:47758 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oCPyO-00C0d2-IH; Fri, 15 Jul 2022 12:23:32 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Alexey Gladkov <legion@kernel.org>
References: <20220713155405.80663-1-ubizjak@gmail.com>
        <20220713155405.80663-2-ubizjak@gmail.com>
Date:   Fri, 15 Jul 2022 13:23:24 -0500
In-Reply-To: <20220713155405.80663-2-ubizjak@gmail.com> (Uros Bizjak's message
        of "Wed, 13 Jul 2022 17:54:04 +0200")
Message-ID: <87pmi6z143.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oCPyO-00C0d2-IH;;;mid=<87pmi6z143.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18MbqT3CXN1kNXhfwIMr6VdUIYGJgSWu9I=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *****;Uros Bizjak <ubizjak@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 271 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 12 (4.3%), b_tie_ro: 10 (3.7%), parse: 1.18
        (0.4%), extract_message_metadata: 13 (4.6%), get_uri_detail_list: 1.06
        (0.4%), tests_pri_-1000: 17 (6.2%), tests_pri_-950: 1.44 (0.5%),
        tests_pri_-900: 1.23 (0.5%), tests_pri_-90: 46 (16.9%), check_bayes:
        44 (16.2%), b_tokenize: 4.5 (1.7%), b_tok_get_all: 3.4 (1.3%),
        b_comp_prob: 1.55 (0.6%), b_tok_touch_all: 31 (11.5%), b_finish: 0.90
        (0.3%), tests_pri_0: 167 (61.7%), check_dkim_signature: 0.85 (0.3%),
        check_dkim_adsp: 3.3 (1.2%), poll_dns_idle: 1.04 (0.4%), tests_pri_10:
        2.1 (0.8%), tests_pri_500: 7 (2.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/2] ucount: Fix atomic_long_inc_below argument type
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uros Bizjak <ubizjak@gmail.com> writes:

> The type of u argument of atomic_long_inc_below should be long
> to avoid unwanted truncation to int.

Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>

>
> Fixes: f9c82a4ea89c ("Increase size of ucounts to atomic_long_t")
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  kernel/ucount.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/ucount.c b/kernel/ucount.c
> index 06ea04d44685..974ac1585009 100644
> --- a/kernel/ucount.c
> +++ b/kernel/ucount.c
> @@ -216,7 +216,7 @@ void put_ucounts(struct ucounts *ucounts)
>  	}
>  }
>  
> -static inline bool atomic_long_inc_below(atomic_long_t *v, int u)
> +static inline bool atomic_long_inc_below(atomic_long_t *v, long u)
>  {
>  	long c, old;
>  	c = atomic_long_read(v);
