Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92E948DAA4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 16:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbiAMPWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 10:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236064AbiAMPWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 10:22:50 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4FFC06173F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 07:22:49 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id u25so24411801edf.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 07:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nzMY5R1szsmGJFUlwbINM+T7vzjcOlUYFVZu+aICBPQ=;
        b=A3YbgQlNPJgQJby1jkG/1O6/A2Em9+U44VS5IzjLG5jm4nHAa00VKQF8lC1NIGrxmr
         axD+juGubcP+iFwJbjoo/LtUyMueDA84vOceNJ2xauOuu9/wRFs/bUJWo8bp/eJ2GIOm
         /sy2qWFuHhqSBG0bMwhHBDiBjT+aRBJhA2kDYLCGu+AaCs9sHYB7INBJrTIN/ZFB9l8x
         Dy2aF4ouoT0cF7arFp0iat2AzWx/VdGyzHGZ5aOIS2gbG3ZQLJF/MOIgD1cF7Re/rFFZ
         XTmuobxdZz7nssRRn2F5mcgIaxqU0Rt59kHmZTke8WO47xAOhBe5+s4Gd0p7E7vHllcD
         fDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nzMY5R1szsmGJFUlwbINM+T7vzjcOlUYFVZu+aICBPQ=;
        b=tK2lP5TzO378rsLHcIeZcu5e478HXJgI9pPSaTg7TDvbLZl2+85wbOeIHB6Gzr7/1G
         f5jhnDrRHKC7S6FdFQxF4uLSJW+H48iHn2NQHt8VR67734btYw3u3sCYFEHtvzbxMI6T
         6Qv/T8jEvy5BmMuWZcpEfCR1Kwi+qWKv/HOiwcHRG2H1I+cRpDEQn8Jan4nVh6lupwvI
         09LdM4gCZmPTQ+oe5q7JU1vNgyTbkKc2MH4mlqCWItc+m9QIUJIhX7uujkUa41tPKldj
         lUEcybXRSeuKXq/0OQ/+gvPZfoI1U7kFZkKdVAx9nk2RnUzbn5l4Ujpm/+kecjEacRRv
         3CLw==
X-Gm-Message-State: AOAM532szw2wCchbiQq+2Cx+2XnpjrsiDDHYA+MunGqv3Zjo8HDU08KM
        pRPVtt4EwiOlOW92YDLjYSOZfznScz2k3TvDVB7Y
X-Google-Smtp-Source: ABdhPJxkxr7X/MPw32HWMSvTZAaBzln0Ro34QATz9zbnp5ECQbBzvi9XQTbJTtzoGymYDkr6u/PXkS5lR7ne6vCmodU=
X-Received: by 2002:a17:907:6d01:: with SMTP id sa1mr3746651ejc.517.1642087368369;
 Thu, 13 Jan 2022 07:22:48 -0800 (PST)
MIME-Version: 1.0
References: <96f4f1cb-0e7d-6682-ce33-f7f1314cba83@huawei.com> <8b487a19-d121-5fee-eda5-0aee9340f453@huawei.com>
In-Reply-To: <8b487a19-d121-5fee-eda5-0aee9340f453@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 13 Jan 2022 10:22:37 -0500
Message-ID: <CAHC9VhTGTmNzFURkAPm2LW3qL+ijBi=UmXqZBwEWeusC46+8yg@mail.gmail.com>
Subject: Re: Flush the hold queue fall into an infinite loop.
To:     cuigaosheng <cuigaosheng1@huawei.com>
Cc:     linux-audit@redhat.com, Xiujianfeng <xiujianfeng@huawei.com>,
        wangweiyang <wangweiyang2@huawei.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 6:57 AM cuigaosheng <cuigaosheng1@huawei.com> wrote=
:
>
> When we add "audit=3D1" to the cmdline, kauditd will take up 100%
> cpu resource.As follows:
>
> configurations:
> auditctl -b 64
> auditctl --backlog_wait_time 60000
> auditctl -r 0
> auditctl -w /root/aaa  -p wrx
> shell scripts=EF=BC=9A
> #!/bin/bash
> i=3D0
> while [ $i -le 66 ]
> do
>    touch /root/aaa
>    let i++
> done
> mandatory conditions:
>
> add "audit=3D1" to the cmdline, and kill -19 pid_number(for /sbin/auditd)=
.
>
>  As long as we keep the audit_hold_queue non-empty, flush the hold queue =
will fall into
>  an infinite loop.
>
> 713 static int kauditd_send_queue(struct sock *sk, u32 portid,
>  714                               struct sk_buff_head *queue,
>  715                               unsigned int retry_limit,
>  716                               void (*skb_hook)(struct sk_buff *skb),
>  717                               void (*err_hook)(struct sk_buff *skb))
>  718 {
>  719         int rc =3D 0;
>  720         struct sk_buff *skb;
>  721         unsigned int failed =3D 0;
>  722
>  723         /* NOTE: kauditd_thread takes care of all our locking, we ju=
st use
>  724          *       the netlink info passed to us (e.g. sk and portid) =
*/
>  725
>  726         while ((skb =3D skb_dequeue(queue))) {
>  727                 /* call the skb_hook for each skb we touch */
>  728                 if (skb_hook)
>  729                         (*skb_hook)(skb);
>  730
>  731                 /* can we send to anyone via unicast? */
>  732                 if (!sk) {
>  733                         if (err_hook)
>  734                                 (*err_hook)(skb);
>  735                         continue;
>  736                 }
>  737
>  738 retry:
>  739                 /* grab an extra skb reference in case of error */
>  740                 skb_get(skb);
>  741                 rc =3D netlink_unicast(sk, skb, portid, 0);
>  742                 if (rc < 0) {
>  743                         /* send failed - try a few times unless fata=
l error */
>  744                         if (++failed >=3D retry_limit ||
>  745                             rc =3D=3D -ECONNREFUSED || rc =3D=3D -EP=
ERM) {
>  746                                 sk =3D NULL;
>  747                                 if (err_hook)
>  748                                         (*err_hook)(skb);
>  749                                 if (rc =3D=3D -EAGAIN)
>  750                                         rc =3D 0;
>  751                                 /* continue to drain the queue */
>  752                                 continue;
>  753                         } else
>  754                                 goto retry;
>  755                 } else {
>  756                         /* skb sent - drop the extra reference and c=
ontinue */
>  757                         consume_skb(skb);
>  758                         failed =3D 0;
>  759                 }
>  760         }
>  761
>  762         return (rc >=3D 0 ? 0 : rc);
>  763 }
>
> When kauditd attempt to flush the hold queue, the queue parameter is &aud=
it_hold_queue,
> and if netlink_unicast(line 741 ) return -EAGAIN, sk will be NULL(line 74=
6), so err_hook(kauditd_rehold_skb)
> will be call. Then continue, skb_dequeue(line 726) and err_hook(kauditd_r=
ehold_skb,line 733) will
> fall into an infinite loop.
> I don't really understand the value of audit_hold_queue, can we remove it=
, or stop droping the logs
> into kauditd_rehold_skb when the auditd is abnormal?

Thanks Gaosheng for the bug report, I'm able to reproduce this and I'm
looking into it now.  I'll report back when I have a better idea of
the problem and a potential fix.

--=20
paul moore
www.paul-moore.com
