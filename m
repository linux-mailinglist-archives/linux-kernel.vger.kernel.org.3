Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371D559E929
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbiHWRWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237471AbiHWRUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:20:42 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB79AE86E
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 06:44:25 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id cr9so10322536qtb.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 06:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc;
        bh=HYUWsAYXjW2i318BjbGbbKb+gkXQpUmwzmEIHMqDu5I=;
        b=e4JErC0om1kvlDhOah9NQNcK+mXjibntNm23OS49JJRMoTF5yVIe6jgHxK1+mhwkan
         CO91j95hoO+ZUqzvsHtB+vnZLWg5cZJTdAZd/KyriCrgfWZdH7J4b2bD2+oxHYpW5Ynh
         bkfus5PrWDnnJai7yYslwwf0RJuvDjfZaW+T0ptWq1/uK1BfD0hq28qJyA5EosXuFBwl
         LkroYPa5I6Jo56BQ5J86APmQj3fL+ojhLy+K7MEeJcpl/hMMdk9E+NQb6kTG1BmUr1Im
         sChiFOU8KqdQH94ddHL7Teh5gp6YtpdjEWwaUUOb6/Dvss/yiCnPdZp8HNkmZgcmZZ5n
         Xyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=HYUWsAYXjW2i318BjbGbbKb+gkXQpUmwzmEIHMqDu5I=;
        b=Nz6RAAc3P6f7PS25j+ECR96TWcYSMPSKMxW3uVP6iYejU3lLzyQBjLYShpwLzyAvsR
         CECTUVdD4mAmpeiQcz3ca/kkgIYhnsuF1w+/sGN2h24EbRg0p0BSt73JPISTkgxnFT6z
         IImFjTKONIiC6IedKcyVVF8yLdc/MiovpUaxfRLHI566m7j5X1wSf1tJZsB6DvIZvwbD
         zOLuVmZKP4Do0B5Uc4h8vDSjHKSVQLmh6vSV99Qf+VCRgsPYTdBd1/xQoqIGNfml2N6g
         6UUlztXYijaDCDJrSC+AMOxoD6p9KFvdwxKhDchZN/eveD+PGtx7gkkhJGRqv4BUGFLE
         6WEQ==
X-Gm-Message-State: ACgBeo1Xpnm3CthF5OLM7N78av+D4RPoefkkBrYYqhU3MqihlhY99pnn
        UJ/ZDZ47W/rdKOMd11YSPsW6yA==
X-Google-Smtp-Source: AA6agR4t4vEazDNxYLh6eNEskT0+EKTIuQlsSu8YV3eXOkr/7tQ7UIDxzDgxf4QyRfzrcYAMvvoZeg==
X-Received: by 2002:ac8:7e83:0:b0:344:7ee0:1241 with SMTP id w3-20020ac87e83000000b003447ee01241mr19324435qtj.587.1661262264917;
        Tue, 23 Aug 2022 06:44:24 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id v16-20020a05620a0f1000b006b97151d2b3sm13198030qkl.67.2022.08.23.06.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 06:44:24 -0700 (PDT)
Message-ID: <ede840d10677041d2c8d0a07b81b3cd55a6c92ba.camel@ndufresne.ca>
Subject: Re: [PATCH 2/2] [WIP]: media: Add Synaptics compressed tiled format
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Hsia-Jun Li <Randy.Li@synaptics.com>
Cc:     Tomasz Figa <tfiga@chromium.org>, dri-devel@lists.freedesktop.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, sakari.ailus@linux.intel.com,
        ribalda@chromium.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.hesselbarth@gmail.com, jszhang@kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 23 Aug 2022 09:44:22 -0400
In-Reply-To: <2f3c8f6d-fc01-353e-fb74-b7f9af1ed2c4@synaptics.com>
References: <20220808162750.828001-1-randy.li@synaptics.com>
         <20220808162750.828001-3-randy.li@synaptics.com>
         <CAAFQd5AKjpJ+fPAeCqdNnJbS4R7SdaHkfyW4qG1xXr-sE801pQ@mail.gmail.com>
         <13d37c15-79f3-4e16-8cf4-fc37846f4a04@synaptics.com>
         <Yv7HnHE7bLmgq5D0@pendragon.ideasonboard.com>
         <6da7faf329128312f0862f555d1a855437ae99f3.camel@ndufresne.ca>
         <50dd9b7a-8f48-0799-57f6-048d20de8dcc@synaptics.com>
         <2662ac698898f71f60b9b7e0ad4703854de1d012.camel@ndufresne.ca>
         <1f926989-eb13-14ee-e30d-ac6d01b86c52@synaptics.com>
         <e15165f60ce801dd502bfe1992ea430fe37c5a91.camel@ndufresne.ca>
         <2f3c8f6d-fc01-353e-fb74-b7f9af1ed2c4@synaptics.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 23 ao=C3=BBt 2022 =C3=A0 15:40 +0800, Hsia-Jun Li a =C3=A9crit=C2=
=A0:
> > In current state, If your driver can support it, userland does not stri=
ctly
> > need
> > to re-allocate if the resolution is changed to smaller. In most SVC
> > scenarios,
> > the largest resolution is known in advance, so pre-allocation can happe=
n to
> > the
> When you play a video from Youtube, you may notice that starting=20
> resolution is low, then after it received more data knowning the=20
> bandwidth is enough, it would switch to a higher resolution. I don't=20
> think it would inform the codecs2 or OMX there is a higher target=20
> resolution.
>=20
> Besides, for the case of SVC in a conference system, the remote(gatway)=
=20
> would not tell you there is a higer resolution or frame rate because you=
=20
> can't receive it in negotiate stage, it could be permanently(device=20
> capability) or just bandwidth problem. Whether we know there is a higher=
=20
> requirement video depends on the transport protocols used here.
>=20
> The basic idea of SVC is that the low layer didn't depends on the upper=
=20
> layer, we can't tell how the bitstream usually.

I'm not saying against the fact the for drivers without IOMMU (hitting dire=
ctly
into the CMA allocator), allocation latency is massive challenge, and a
mechanism to smoothly reallocate (rather then mass-reallocation) is needed =
in
the long run. This is what I'm referring to when saying that folks have
considered extending CREATE_BUFS() with a DELETE_BUFS() ioctl.

Note that there is tones of software trickery you can use to mitigate this.=
 The
most simple one is to use CREATE_BUFS() instead of REQBUFS(). Instead of
reallocating all the buffers you need in one go, you would allocate them on=
e by
one. This will distribute allocation latency. For stateful CODEC, most OMX
focused firmware needs to be modified for that, since they stick with the o=
ld
OMX spec which did not allow run-time allocation.

Another trick is to use a second codec session. Both stateful/stateless COD=
EC
have support for concurrent decoding. On the MSE requirement, is that the s=
tream
transition happens only on keyframe boundary. Meaning, there is no need to =
reuse
the same session, you can create a new decoder in parallel, and that before=
 the
drain is complete (after the event, before the last buffer). This will comp=
ress
the "setup" latency, to the cost of some extra memory usage. Specially in t=
he
MSE case, this is nearly always possible since browsers do require support =
for
more then 1 concurrent decode. This method also works with OMX style CODEC
without any modification.

regards,
Nicolas



