Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C71590592
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 19:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbiHKRP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 13:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236594AbiHKRPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:15:39 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30EE26D0;
        Thu, 11 Aug 2022 10:02:44 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id k26so34590774ejx.5;
        Thu, 11 Aug 2022 10:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=PLSc3JU04wr/3xDHUZJS4oaaEMeBTMvazU5HyZg/WI4=;
        b=SAVJ5zR9JddbuKzT5hRanszuHdxdjoExu2TYW3REctrGZMePVRgV3B7dzLGn0bjf6W
         Oak3KtKixZx+P6L3u/ilCCn4y7zQN8Tf2e3Am3GYzbhqqv7/0TnyloXpJXfdZqGAEuz/
         LLOa2m0O23hL9qqTamfnmjrSts1P16/k9wct4lKAy+u0QHq52pxNxaW7I3CqQ9/qCuGW
         ZOEk1K/fiEp3AvDs00MFVSgpshfiKxHRnLL34gQI+DasI87LsISY5qzvaQDJyM2YM8TY
         9Rgovx2f5mSA8bkFEOJ7o/N94WQ6dkpD0bzI00G2Dl9lF0ovijiHSQHFIqvxp5YKkWDg
         6hJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=PLSc3JU04wr/3xDHUZJS4oaaEMeBTMvazU5HyZg/WI4=;
        b=zGgQdahtPZImDPrVNPvFrUOPsUau4ijQo2uekUFK+7rWTMNosYgUfR4kF1I+N661tK
         GEIld0ho2k29PmdoyMwMaPdfzPbQ1gu3zomhVPW1QCEZzk1qqqBVVOxFzl+CydTNz0CU
         2UvTCTRHYXPfdSlisT/ugMKFcqrmkpNLi8ThBfZ0vVcYUGLjYeF4w2Vm+pbhQ8W8XkX8
         aHTJMzAScX1mR5JtcpSBPUrqV9R4KhPSUJ8n6gf3CwXBH9vpaJ6Iwg2BXlZGSAI/krAZ
         EyWYPhv67vrawPqVLIngdxv/kaBF3ZFuspb50NGpEGYArX2kxkNcsJmhKYqKcNIGTbXo
         FS4Q==
X-Gm-Message-State: ACgBeo0ad/8ktFwLkqwUVcLxkRxEpB8yVdd5MQlIOWo/89uUVj/Yv6yH
        mZKC9Xi1fItiDq3wDSnjpm/8cf1+aF6RXh8dSf8=
X-Google-Smtp-Source: AA6agR728AXZe+1Bz58HAgWvrpVI2DC3FmCsAy87AqMJW42NkGuK/bFFfkfGJq6ADtpvgeJKTBsLOT0ttauLYGMBOeY=
X-Received: by 2002:a17:906:8cb0:b0:730:d6f3:279e with SMTP id
 qr48-20020a1709068cb000b00730d6f3279emr3753ejc.25.1660237363214; Thu, 11 Aug
 2022 10:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220807221152.38948-1-Igor.Skalkin@opensynergy.com>
 <20220807185846-mutt-send-email-mst@kernel.org> <02222fcb-eaba-617a-c51c-f939678e3d74@opensynergy.com>
 <20220808081054-mutt-send-email-mst@kernel.org> <20220811035817-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220811035817-mutt-send-email-mst@kernel.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 11 Aug 2022 10:02:31 -0700
Message-ID: <CABBYNZKZGxbt=jdpBL77x1mCeTPdDE-p-Pt8JjZN+KoRgR3Ohw@mail.gmail.com>
Subject: Re: [PATCH] virtio_bt: Fix alignment in configuration struct
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Igor Skalkin <igor.skalkin@opensynergy.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        mgo@opensynergy.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Thu, Aug 11, 2022 at 1:00 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Aug 08, 2022 at 08:16:11AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Aug 08, 2022 at 02:04:43PM +0200, Igor Skalkin wrote:
> > > On 8/8/22 01:00, Michael S. Tsirkin wrote:
> > >
> > >     On Mon, Aug 08, 2022 at 12:11:52AM +0200, Igor Skalkin wrote:
> > >
> > >         According to specification [1], "For the device-specific conf=
iguration
> > >         space, the driver MUST use 8 bit wide accesses for 8 bit wide=
 fields,
> > >         16 bit wide and aligned accesses for 16 bit wide fields and 3=
2 bit wide
> > >         and aligned accesses for 32 and 64 bit wide fields.".
> > >
> > >         Current version of the configuration structure:
> > >
> > >             struct virtio_bt_config {
> > >                 __u8  type;
> > >                 __u16 vendor;
> > >                 __u16 msft_opcode;
> > >             } __attribute__((packed));
> > >
> > >         has both 16bit fields non-aligned.
> > >
> > >         This commit fixes it.
> > >
> > >         [1] https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v=
1/query?url=3Dhttps%3a%2f%2fdocs.oasis%2dopen.org%2fvirtio%2fvirtio%2fv1.1%=
2fvirtio%2dv1.1.pdf&umid=3Dd1786ace-e8ea-40e8-9665-96c0949174e5&auth=3D53c7=
c7de28b92dfd96e93d9dd61a23e634d2fbec-39b15885ceebe9fda9357320aec1ccbac416a4=
70
> > >
> > >         Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
> > >
> > >     This is all true enough, but the problem is
> > >     1. changing uapi like this can't be done, will break userspace
> > >     2. the driver has more issues and no one seems to want to
> > >        maintain it.
> > >     I posted a patch "Bluetooth: virtio_bt: mark broken" and intend
> > >     to merge it for this release.
> > >
> > > This is very sad. We already use this driver in our projects.
> >
> > Really?  Can you step up to maintain it? Then we can fix the issues
> > and it won't be broken.
>
> Just a reminder that I'm waiting for a response on that.
> I just don't know enough about bluetooth.

Just a heads up that Marcel is on vacation, he did mention that he had
done some work to update virtio_bt thus why I didn't apply any of the
changes yet.

> --
> MST
>


--=20
Luiz Augusto von Dentz
