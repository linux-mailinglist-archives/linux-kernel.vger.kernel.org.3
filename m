Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51FBD48F27E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 23:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiANWfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 17:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiANWfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 17:35:32 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18017C06161C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 14:35:32 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 30so39203146edv.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 14:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SkNpdM6eZXXVcJVQ11NWOZFwVrMmc4tVgm0vVCXMsxQ=;
        b=EYsmK1W8Io0FJyX9tdKZBPvMidx0Rkrh04CvcIo2kLwyFF6JDItVeLXuGEtyu4Zuec
         W21Rgff1lgsJIBTNEDBFbLEd5u2867bSZ7hAAqKs3JUSFvW5OfdsEv+GPhxWEyFzNrIe
         eobV42h4uRes/TAbr/mtTfylKWSQNQ6EBRnp0awgChmLa6s2tx5NpqjT5Rr/NFOzBLOC
         1WMqyVeDPSHRFmjcvZ+rcx1+if45EqfkR1dPCYs35Vt1j7dLCKuTV+m3IupIROtr92Su
         1YnJEOyGqePtgtLu6jH6D5HfvKq+StEczp1R9TUyUJykUZVksZb5Cv8aSELRnvnPQS/j
         6X/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SkNpdM6eZXXVcJVQ11NWOZFwVrMmc4tVgm0vVCXMsxQ=;
        b=dfjbNuzR25DW2dWzqLPNuYoKz2G+xQ5RJ4IjW/c/mbPkk1r58pNEyc5Edxlbd2jek8
         JXxg8OfM0jfEDWZfLC+407Fj+0b7jLoHxqXczcqU1yxyloXU3RRNeOOiPJLy5U7mbchD
         6QA6YFz//BEnxWdLbBMz5d4yGXZP098xQUPiBXBujqGdO3dpnUaSH1D+u57CKQcw/E2M
         SzIWQiEkf+o17CoeST+Xr9C5aE45ah3W5T2v09PspSnSdW/jys7RsAc92SbGhYCcAWnb
         PrS8aMQiTtffjOgQ/IUC+CSFGduLekMtYak3qiEGF36zGhOxBhPxdpZuZ/lRExRj7v4u
         Wrow==
X-Gm-Message-State: AOAM5304j/nXoe/za6m9la2oDDzwHvYJCb1o/lDx0ebnY20GWJms9DwT
        /z+/3otuvX0lKBKIBeBL2of1q3pEBRy7RE4PYX/0
X-Google-Smtp-Source: ABdhPJzPoytqdXbJteXXJAmYxB6IAgK+i9VGw6/4V0dSsyNdXqdE2nhD8yJFIVugl0Eb/KHOU9I0xJdwmdkxqZWszC4=
X-Received: by 2002:a05:6402:1003:: with SMTP id c3mr10879904edu.405.1642199729820;
 Fri, 14 Jan 2022 14:35:29 -0800 (PST)
MIME-Version: 1.0
References: <96f4f1cb-0e7d-6682-ce33-f7f1314cba83@huawei.com>
 <8b487a19-d121-5fee-eda5-0aee9340f453@huawei.com> <CAHC9VhTGTmNzFURkAPm2LW3qL+ijBi=UmXqZBwEWeusC46+8yg@mail.gmail.com>
 <c0f9b9b3-69a3-1b31-5115-51dd580e00ca@huawei.com>
In-Reply-To: <c0f9b9b3-69a3-1b31-5115-51dd580e00ca@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 14 Jan 2022 17:35:18 -0500
Message-ID: <CAHC9VhQgX070pOXZk_PUsaWGZpPdqVpEZvfYBsE2dnRYrbWsTw@mail.gmail.com>
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

On Thu, Jan 13, 2022 at 8:22 PM cuigaosheng <cuigaosheng1@huawei.com> wrote=
:
>
> I want to stop droping the logs into audit_hold_queue when the auditd is =
abnormal.it
> seems that this modification goes against the design intent of audit_hold=
_queue. its
> effect is similar to removing the audit_hold_queue.
>
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 2a38cbaf3ddb..a8091b1a6587 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -748,6 +748,7 @@ static int kauditd_send_queue(struct sock *sk, u32
> portid,
>                                          (*err_hook)(skb);
>                                  if (rc =3D=3D -EAGAIN)
>                                          rc =3D 0;
> +                               audit_default =3D AUDIT_OFF;
>                                  /* continue to drain the queue */
>                                  continue;
>                          } else
> @@ -755,6 +756,7 @@ static int kauditd_send_queue(struct sock *sk, u32
> portid,
>                  } else {
>                          /* skb sent - drop the extra reference and
> continue */
>                          consume_skb(skb);
> +                       audit_default =3D audit_enabled;
>                          failed =3D 0;
>                  }
>          }

We can't toggle the audit_default setting like this, that isn't
acceptable upstream.  I believe I have a fix, but I need to finish the
testing before I can post it for further review.

> =E5=9C=A8 2022/1/13 23:22, Paul Moore =E5=86=99=E9=81=93:
> > On Thu, Jan 13, 2022 at 6:57 AM cuigaosheng <cuigaosheng1@huawei.com> w=
rote:
> >> When we add "audit=3D1" to the cmdline, kauditd will take up 100%
> >> cpu resource.As follows:
> >>
> >> configurations:
> >> auditctl -b 64
> >> auditctl --backlog_wait_time 60000
> >> auditctl -r 0
> >> auditctl -w /root/aaa  -p wrx
> >> shell scripts=EF=BC=9A
> >> #!/bin/bash
> >> i=3D0
> >> while [ $i -le 66 ]
> >> do
> >>     touch /root/aaa
> >>     let i++
> >> done
> >> mandatory conditions:
> >>
> >> add "audit=3D1" to the cmdline, and kill -19 pid_number(for /sbin/audi=
td).
> >>
> >>   As long as we keep the audit_hold_queue non-empty, flush the hold qu=
eue will fall into
> >>   an infinite loop.
> >>
> >> 713 static int kauditd_send_queue(struct sock *sk, u32 portid,
> >>   714                               struct sk_buff_head *queue,
> >>   715                               unsigned int retry_limit,
> >>   716                               void (*skb_hook)(struct sk_buff *s=
kb),
> >>   717                               void (*err_hook)(struct sk_buff *s=
kb))
> >>   718 {
> >>   719         int rc =3D 0;
> >>   720         struct sk_buff *skb;
> >>   721         unsigned int failed =3D 0;
> >>   722
> >>   723         /* NOTE: kauditd_thread takes care of all our locking, w=
e just use
> >>   724          *       the netlink info passed to us (e.g. sk and port=
id) */
> >>   725
> >>   726         while ((skb =3D skb_dequeue(queue))) {
> >>   727                 /* call the skb_hook for each skb we touch */
> >>   728                 if (skb_hook)
> >>   729                         (*skb_hook)(skb);
> >>   730
> >>   731                 /* can we send to anyone via unicast? */
> >>   732                 if (!sk) {
> >>   733                         if (err_hook)
> >>   734                                 (*err_hook)(skb);
> >>   735                         continue;
> >>   736                 }
> >>   737
> >>   738 retry:
> >>   739                 /* grab an extra skb reference in case of error =
*/
> >>   740                 skb_get(skb);
> >>   741                 rc =3D netlink_unicast(sk, skb, portid, 0);
> >>   742                 if (rc < 0) {
> >>   743                         /* send failed - try a few times unless =
fatal error */
> >>   744                         if (++failed >=3D retry_limit ||
> >>   745                             rc =3D=3D -ECONNREFUSED || rc =3D=3D=
 -EPERM) {
> >>   746                                 sk =3D NULL;
> >>   747                                 if (err_hook)
> >>   748                                         (*err_hook)(skb);
> >>   749                                 if (rc =3D=3D -EAGAIN)
> >>   750                                         rc =3D 0;
> >>   751                                 /* continue to drain the queue *=
/
> >>   752                                 continue;
> >>   753                         } else
> >>   754                                 goto retry;
> >>   755                 } else {
> >>   756                         /* skb sent - drop the extra reference a=
nd continue */
> >>   757                         consume_skb(skb);
> >>   758                         failed =3D 0;
> >>   759                 }
> >>   760         }
> >>   761
> >>   762         return (rc >=3D 0 ? 0 : rc);
> >>   763 }
> >>
> >> When kauditd attempt to flush the hold queue, the queue parameter is &=
audit_hold_queue,
> >> and if netlink_unicast(line 741 ) return -EAGAIN, sk will be NULL(line=
 746), so err_hook(kauditd_rehold_skb)
> >> will be call. Then continue, skb_dequeue(line 726) and err_hook(kaudit=
d_rehold_skb,line 733) will
> >> fall into an infinite loop.
> >> I don't really understand the value of audit_hold_queue, can we remove=
 it, or stop droping the logs
> >> into kauditd_rehold_skb when the auditd is abnormal?
> > Thanks Gaosheng for the bug report, I'm able to reproduce this and I'm
> > looking into it now.  I'll report back when I have a better idea of
> > the problem and a potential fix.
> >



--=20
paul moore
www.paul-moore.com
