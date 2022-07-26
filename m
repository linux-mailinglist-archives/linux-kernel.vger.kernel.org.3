Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97BA5810CB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 12:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbiGZKHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 06:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238211AbiGZKHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 06:07:30 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473C9CE12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 03:07:29 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id c131so24482422ybf.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 03:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eptp1f76nSR7hEUsePloA5aK8E66pD/xnYvzEDwBNmM=;
        b=kYYITZtLdjINtcyVlpignWgeGX4iav62tqrI7FVm6/Xt9pZ0dSulgYQK9/aL9XNzeg
         Dx3KZBuVwHCKvNENqX0oDFJ/KHlBD/ZtkYZOAi8nzAhseZfsPhCffPh1OZMFqtasLVF0
         GFPP/JDfDjnDFqbw3vcC541SiTSV5CU8bgJkfQhqPhtg31smFhE1Y3BL8Tr+btd4fYj2
         6FbM+ZzgrNAlhlExwG5J2ha4peQEkbO09NncgIVXY2c8+w+oBwn8ErjjZtRxly0UBuYY
         H2KSxJIacnKVSEwvvGNJ3MN4iBKMilSa6XPHab2qXegjhCUX20MSPmgEGGRE8bxh/n2w
         Vcpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eptp1f76nSR7hEUsePloA5aK8E66pD/xnYvzEDwBNmM=;
        b=Ka2Sql6wb/GzdfFr42VqIK8IzQGqwcycILNcHY/ZtQnbTS9dMZp/zEf3iOH4WUkvya
         UBZxIcpg3PBTaUl4xIwIJhHO/n+ePUl4fb+O+AxQTytxU3WpFICM8a6XH8Q+8epYj2h6
         VklDyat+FTZF3U+skSmAv6CPGy10Z9DgpLRKKzBuSDP75hvv2u9tvqaB/POcc1c4UiTv
         UEz4mgq1Lw/7z4RtwxzI9/iyGiKpp4fmL0IGDUHR4HG/0iog+ovPtQqDVzY2wgpf4zia
         4ppMaZFF624OSJ372Nab1HtARvCBVdskTg8k+VAiOUyPUPP8poDIfVMovQQp/pJNaooN
         MfnA==
X-Gm-Message-State: AJIora8dA6lEAa9lOptNP0tKV6hnVCYMdhYtD0FOHxm/zSGTx/SHRztM
        221w5++Mj3AmkG830pLhtFRvR5sk+L8UuQKtwZdVKg==
X-Google-Smtp-Source: AGRyM1tUPgbPgGLtSzX4pvr8Ba22P4rYPqMQlG+L2K39fjjMFw2BowaAtAGTwG1EoVhuNFpFgMoVUB+142tJDEbYb8U=
X-Received: by 2002:a05:6902:114b:b0:66f:d0:57c7 with SMTP id
 p11-20020a056902114b00b0066f00d057c7mr12779019ybu.55.1658830048241; Tue, 26
 Jul 2022 03:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220701145423.53208-1-code@siddh.me>
In-Reply-To: <20220701145423.53208-1-code@siddh.me>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 26 Jul 2022 12:07:16 +0200
Message-ID: <CANn89iLN27NWA7Stkr4ODp6V-Q-3em0dJ2JixDMNcNY7Ap5muA@mail.gmail.com>
Subject: Re: [PATCH] net: Fix UAF in ieee80211_scan_rx()
To:     Siddh Raman Pant <code@siddh.me>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 1, 2022 at 4:55 PM Siddh Raman Pant <code@siddh.me> wrote:
>
> ieee80211_scan_rx() tries to access scan_req->flags after a null check
> (see line 303 of mac80211/scan.c), but ___cfg80211_scan_done() uses
> kfree() on the scan_req (see line 991 of wireless/scan.c).
>
> This results in a UAF.
>
> ieee80211_scan_rx() is called inside a RCU read-critical section
> initiated by ieee80211_rx_napi() (see line 5043 of mac80211/rx.c).
>
> Thus, add an rcu_head to the scan_req struct so as to use kfree_rcu()
> instead of kfree() so that we don't free during the critical section.
>
> Bug report (3): https://syzkaller.appspot.com/bug?extid=f9acff9bf08a845f225d
> Reported-by: syzbot+f9acff9bf08a845f225d@syzkaller.appspotmail.com
> Reported-by: syzbot+6cb476b7c69916a0caca@syzkaller.appspotmail.com
> Reported-by: syzbot+9250865a55539d384347@syzkaller.appspotmail.com
>
> Signed-off-by: Siddh Raman Pant <code@siddh.me>
> ---
>  include/net/cfg80211.h | 2 ++
>  net/wireless/scan.c    | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index 6d02e12e4702..ba4a49884de8 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -2368,6 +2368,7 @@ struct cfg80211_scan_6ghz_params {
>   * @n_6ghz_params: number of 6 GHz params
>   * @scan_6ghz_params: 6 GHz params
>   * @bssid: BSSID to scan for (most commonly, the wildcard BSSID)
> + * @rcu_head: (internal) RCU head to use for freeing
>   */
>  struct cfg80211_scan_request {
>         struct cfg80211_ssid *ssids;
> @@ -2397,6 +2398,7 @@ struct cfg80211_scan_request {
>         bool scan_6ghz;
>         u32 n_6ghz_params;
>         struct cfg80211_scan_6ghz_params *scan_6ghz_params;
> +       struct rcu_head rcu_head;
>
>         /* keep last */
>         struct ieee80211_channel *channels[];
> diff --git a/net/wireless/scan.c b/net/wireless/scan.c
> index 6d82bd9eaf8c..638b2805222c 100644
> --- a/net/wireless/scan.c
> +++ b/net/wireless/scan.c
> @@ -988,7 +988,7 @@ void ___cfg80211_scan_done(struct cfg80211_registered_device *rdev,
>         kfree(rdev->int_scan_req);
>         rdev->int_scan_req = NULL;
>
> -       kfree(rdev->scan_req);
> +       kfree_rcu(rdev->scan_req, rcu_head);
>         rdev->scan_req = NULL;

Note: this is slightly racy.

You are supposed to follow this order in this situation.

1) Clear the pointer

Then:

2) wait an rcu grace period (synchronize_rcu()) or use call_rcu()/kfree_rcu().



>
>         if (!send_message)
> --
> 2.35.1
>
>
