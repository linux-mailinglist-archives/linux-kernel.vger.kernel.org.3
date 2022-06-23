Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8145578D9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 13:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiFWLkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 07:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiFWLkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 07:40:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F36594BFD6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 04:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655984404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pXX1Tci8u6uSkWlCeJ6TegtPSfgMP3wYaXXEz0pOrgM=;
        b=OaZVVip9LN/4AoDZryX9HsRC1xmCNjwx1AvQoBJZKv+ztF/kGJ9W703UZl9bMq3i0F1iiA
        ty1prNpcnCWCURujDjSvGbxxaFWlNcILTo9RIrUW6ATHn71i2kXPVcBGrq1iYSB2hpkwsZ
        sqzsqpMRmUkiircDI9dI51cZUwIzAqY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-298-upTb53_9P9SB-ChKbmpmgA-1; Thu, 23 Jun 2022 07:40:00 -0400
X-MC-Unique: upTb53_9P9SB-ChKbmpmgA-1
Received: by mail-wm1-f69.google.com with SMTP id p6-20020a05600c358600b0039c873184b9so1302533wmq.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 04:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=pXX1Tci8u6uSkWlCeJ6TegtPSfgMP3wYaXXEz0pOrgM=;
        b=DKS3p6qBOb5bzZ66kWfgJXQZXH8lmoxLhBBr1gUnIFmUv7ts3ApYDUdsYSl30o7M/b
         L8Gr4Z+1eYzHCoECr7bnJklNiu8GFsyg4yME8egsj2Ee7ogfHun9FWTKodUDoT+UhZBc
         S5vFlbzjIjGNh3rqafcMniYLxWloGaKLYPgciqYWxlJVVsztnhuyktMXU2R/HLq32uba
         J+LlfMEFQHy1jHkh5Fy2exxKZA3XXRIeaT82rF80HW+CzKgItQpfK/sxM/Y7xiqT8DIj
         5CspbS5RnEb+3cwCIZAfxHEBZ9WaWQPR99z9psXk4MIfL35ounyU+Z8j3iv/lpeb3UL9
         hyFw==
X-Gm-Message-State: AJIora/UeTSEmADJEbPNT0Lw+jnYXOI7AuCJPs6e/1UTvTYrx/hiuWhG
        dIVwvzyvQ/ZGYn4YHs1UpCJ3/TXTdCUEqfSN21sd8lg/gMbkMwYtYg5VrKafvlynP7SgmFW2nLl
        0wbOgjgSfoiDUZtHI55I3/joR
X-Received: by 2002:adf:dece:0:b0:21b:a4b0:f7e3 with SMTP id i14-20020adfdece000000b0021ba4b0f7e3mr4817782wrn.197.1655984399533;
        Thu, 23 Jun 2022 04:39:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sK/dnm6ZYIya+uSaMaOutOXp1zODWOwg9uNXRImx0f7YrOK+SdjBXJeYaIC5fXn2ZDefBv4A==
X-Received: by 2002:adf:dece:0:b0:21b:a4b0:f7e3 with SMTP id i14-20020adfdece000000b0021ba4b0f7e3mr4817761wrn.197.1655984399335;
        Thu, 23 Jun 2022 04:39:59 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id h30-20020adfaa9e000000b0020c7ec0fdf4sm27013707wrc.117.2022.06.23.04.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 04:39:58 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-rt-users@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH v2] panic, kexec: Make __crash_kexec() NMI safe
In-Reply-To: <YrQzB7sPD8BNxSFq@linutronix.de>
References: <20220620111520.1039685-1-vschneid@redhat.com>
 <YrQzB7sPD8BNxSFq@linutronix.de>
Date:   Thu, 23 Jun 2022 12:39:57 +0100
Message-ID: <xhsmhy1xn622a.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/22 11:31, Sebastian Andrzej Siewior wrote:
> On 2022-06-20 12:15:20 [+0100], Valentin Schneider wrote:
>> Attempting to get a crash dump out of a debug PREEMPT_RT kernel via an N=
MI
>> panic() doesn't work. The cause of that lies in the PREEMPT_RT definition
>> of mutex_trylock():
>>=20
> =E2=80=A6
>
>> Fixes: 6ce47fd961fa ("rtmutex: Warn if trylock is called from hard/softi=
rq context")
>> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>
>> ---
>> v1 -> v2
>> ++++++++
>>=20
>> o Changed from Peterson-like synchronization to simpler atomic_cmpxchg
>>   (Petr)
>> o Slightly reworded changelog
>> o Added Fixes: tag. Technically should be up to since kexec can happen
>>   in an NMI, but that isn't such a clear target
>
> RT-wise it would be needed for each release.

So git tells me the Fixes: commit dates from v4.2; from [1] and [2] I get
that both current longterm stable and stable-rt trees go as far back as
v4.9, so I'm guessing if that gets picked up for the stable trees then it
should make its way into the stable -rt trees?

[1]: https://wiki.linuxfoundation.org/realtime/preempt_rt_versions
[2]: https://www.kernel.org/category/releases.html

> There is also a mutex_unlock() in case an image is missing. This can go
> via the scheduler if there is a waiter which does not look good with the
> NMI in the picture.
>
> Sebastian

