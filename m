Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36783599520
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 08:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244869AbiHSGB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 02:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiHSGB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 02:01:57 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2433EC6B75
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660888904;
        bh=MOCsnQKUtAhXlHqssFSM8e9zPQnE4nRVmCO+9ySWwD8=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=MteOxIZEHxZoTSMmIqIQ1Mq98+zDcB/vmfZ3AwDIsZj7OJxB9Q1BfsO1sph73Rgkk
         vHMYpzRSMRr+h/0V+us95n9YqOASk03v6w9nB9aC7X4ffFce+0pJdJKGk29onnkvkF
         cSYP0wy49MKa6SiktIZlje+1Zcbg4z1MpAE+L02E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.149.72]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2wL0-1oLckm1T2a-003Jn6; Fri, 19
 Aug 2022 08:01:44 +0200
Message-ID: <f75cb32b7c262fe852c53544034f5b6047d29b65.camel@gmx.de>
Subject: Re: [PATCH v5 3/5] vduse: Support using userspace pages as bounce
 buffer
From:   Mike Galbraith <efault@gmx.de>
To:     Xie Yongji <xieyongji@bytedance.com>, jasowang@redhat.com,
        mst@redhat.com, xiaodong.liu@intel.com, maxime.coquelin@redhat.com,
        stefanha@redhat.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 19 Aug 2022 08:01:42 +0200
In-Reply-To: <20220803045523.23851-4-xieyongji@bytedance.com>
References: <20220803045523.23851-1-xieyongji@bytedance.com>
         <20220803045523.23851-4-xieyongji@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ID0sMTVYy3r3ajuvly3x/Qa+Opaue78Rbt3wTx4fEj5BT/3Hz53
 bdOlV+5UEOdhuXKQ2XhIpddyk9+zTTCmRJZrzHlOMhWcy8B5p/nyXLr/YYl/587a/uTlj4v
 7KWCHZ3Osyv4A79qGad8cDxLWuGo+y31xxYn3/D+Er4BLuJiAjtw2P4RANpdlqW9v8lncUG
 4/fndY1uK0k6eyLV8p/3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Qh345vWtFwU=:Jukzri2cfMBZqn6mFt3RcV
 LkaQVzvgqP1lxPobhGvQoGQmSH6bwPgBxx9h6sw/JhlOxW25/XDeoS7A5J2mRVNm29wsZAEQF
 wPoxwfEkLWqOJ+qUQjP5ZFLXtdYPkwz99LE1YXp1DzFj2tcT0NFpYFrVIfgn+M65E82BPnrFJ
 OP5vlAjpxAQ2+KslzkyIML94x+8Ev0C0kACxn15vvl218ATNFfrCTf6kYO3yoTDaf2On84R1F
 KKchLK00noWaLT85bmK6IbqEyXECZJXG77iRAjDkpdiUXJNmcmUT9GzS3nif8L33KxJz+bLiS
 aq9lOvyWgA6lUHlISFCczhyUeWQ2Wm5z+OSw6P8n8RIL6wbanT5iwm5j0U4m5yGdYIKYKk7m9
 cAfxWEPeigsLOB6jHzuEXrmU/SGZ+L4b9omwMqdAO6lN1Ld5XrmwE7sc0IO468iS8oT0z0N9g
 dlTvB5nmhumPIRD4PJtZSHWsUoRoTkLQ/amzwHcTaVnYkv26MTeq7npnuZ88pfN5jdAAObCJi
 uojl7xIMkof4tTyddafbNDxVXDExKQaIbZVEaQyUGZOQmKkpOLlyPou6n7b0p8L1ZBW1fH3NV
 WIO8L1za7AQvIiEnFSO5+TcVG8r3riUf9ptD2ShVnIqenhgVFvrjFwIkAp2P8pj0y/HIj14pO
 0BtScMlbDSU5yOQ1EBl65cRXhHW0UJ5G3A29kN+52k6NV/2KJa2EQ5W7c1OUvBxJhDJRi4Ud6
 S6MgkQwikjbOHN0/ArK6IDLlGn2z5sD39xGbtnCwAGyN5LlFGYBcK3wUzc+OfY9lQILFdLQbI
 dL9raSO4mGGIZGUemnq7BcwK8qZpZXKxFs6nRWACTmsV54KoWC5CgC9KhYxQOiy06EyQZUrFm
 bcmYWmsCM3D2o0YEtmiWe9459gbLdZJbiilTL33wcDUbmLfyy2WZHh8ypvAo0QwRbPZig0MaM
 5ZZrCg2k57lcgExIRV9PfEu57vT+/yeAUw+DD06K6hTxjJXWQ2nu/OJGuer9g84rgX6pJwKAC
 eWHmtszNDbjSgngx7jzmo5lGlBDaMmzg2uQmdxxFchO824lM8j+ipZ2jhM/A3OlejRYfOf1ST
 tKQFhnxOE4nW2jWSusXuK89hkM73D4llNUueT2NDQ4ul8UNBg5JcKYtdA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

On Wed, 2022-08-03 at 12:55 +0800, Xie Yongji wrote:
>
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_us=
er/iova_domain.h
> index 2722d9b8e21a..4e0e50e7ac15 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.h
> +++ b/drivers/vdpa/vdpa_user/iova_domain.h
> @@ -14,6 +14,7 @@
> =C2=A0#include <linux/iova.h>
> =C2=A0#include <linux/dma-mapping.h>
> =C2=A0#include <linux/vhost_iotlb.h>
> +#include <linux/rwlock.h>
                   ^^^^^^^^

Erm, that should be spinlock.h.

#ifndef __LINUX_RWLOCK_H
#define __LINUX_RWLOCK_H

#ifndef __LINUX_SPINLOCK_H
# error "please don't include this file directly"
#endif

This belated comment inspired by PREEMPT_RT build meeting the above :)

	-Mike
