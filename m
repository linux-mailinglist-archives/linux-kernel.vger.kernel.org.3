Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A115ACCF8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237030AbiIEHfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237017AbiIEHfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:35:31 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E783C3A4B5
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 00:35:18 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id u6so10120691eda.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 00:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=/sDanSkrLwd36MY8AyWYKOjcXxKpP3tgOSmTp+6QTpA=;
        b=D/bBnkuE93UwNwWjPCKQjpa3enQb+Sk7crUitNvT11RCoUTD1MApkmLPiuIK2sUgqJ
         bAdjS05gx0CiHnYRVMBYm0/WDjVbvF23aA4eT0RFe/i/vuE7d7C1TFwk0arifEV1PgUK
         GwKTtJz2NnWBJxRVx8r6/5+idCJ3UdvRDEe9afXkxTdjZ2R/43YAqisRJshgwGhVzYOf
         dCez6/QWlMAYS4m2r0URGkWY6gmPiY19KGn03Ajj8XzJ6V4EYN/wNaIobWVuQ9gbS1Zh
         H5zHbyi8PBS+I7MiyWHlG6zbUNR0647HM7YPjyQHIdA8X1jps/pECgr6sVL/Ai8l0m2j
         p1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/sDanSkrLwd36MY8AyWYKOjcXxKpP3tgOSmTp+6QTpA=;
        b=kmULrrhYUJR1mWAjHvnoKzYADVl8/0/yltKn6Ue0FOK4a2qjpw3loSNACxfvDe0HqW
         GzHr9aKqKZnQeDoGAPDUgxAgGpCVG44eQJ2IcrK8aXmmLHulVn/ALD7cZg60HNDvU0aQ
         j5Uf/RqVE3+zVY+sYpvAhe/X8sapAnKIc+BkxhykVAMo62hpW8WTddqKnoJdRBsJy8C5
         SQlG0bq3E0RZb1SomtJaAA0b6Dbg/HIvPqqOG+n6vew5M31Zb0LoBEvJVx0djTTsZT36
         /IPZQ5pXf4bfvE0RgeHHo0JoSvSj7uckfI+ym7VKWFhBO+JH/06AKkJlPkLyq2/jb2qC
         j5lg==
X-Gm-Message-State: ACgBeo0ernfXmjGBzGad1EeWdBBbybfrVDhhv768TGGTTOYk0JNC2lhb
        H1s1WfIYke5TpIPAKQLxdR4HrFdgP4dTIMnTgDY=
X-Google-Smtp-Source: AA6agR41iyuJkZAANMHnLfL8buddmIIsx+cWKwI51aE5VjNWB3uDrqvsCwjulFFkiVv6eU+BBcwjlyGi514bcEIlYok=
X-Received: by 2002:a50:ef03:0:b0:44e:82bf:28e6 with SMTP id
 m3-20020a50ef03000000b0044e82bf28e6mr3074811eds.270.1662363316620; Mon, 05
 Sep 2022 00:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_E1BBF05904DFB73C478DCD592740AAE0780A@qq.com> <CAJedcCxVW++iH49UFZp9ruUuTcNubWCH6Wsqe11K4COB3E8msg@mail.gmail.com>
In-Reply-To: <CAJedcCxVW++iH49UFZp9ruUuTcNubWCH6Wsqe11K4COB3E8msg@mail.gmail.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Mon, 5 Sep 2022 15:35:05 +0800
Message-ID: <CAJedcCw1eJqjSK+yR7eQMDheNtH3Mjm+viwt00xAhnmrfpq2pw@mail.gmail.com>
Subject: Re: [PATCH] drm/i915/gvt: fix double-free bug in split_2MB_gtt_entry.
To:     xmzyshypnc <1002992920@qq.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, zhenyuw@linux.intel.com,
        zhi.a.wang@intel.com, alex000young@gmail.com,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, security@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,
Now the letter is really plain-text now :)
Thanks Greg

Regards,
Zheng Wang

Zheng Hacker <hackerzheng666@gmail.com> =E4=BA=8E2022=E5=B9=B49=E6=9C=885=
=E6=97=A5=E5=91=A8=E4=B8=80 12:47=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello everyone,
>
> I'm Zheng Wang. I found a potential double-free bug in drivers/gpu/drm/i9=
15/gvt/gtt.c. I haven't been replied for a long time. So I decided to send =
it to more relavent supporters and developers to help to solve the problem.
>
> Best regards,
> Zheng Wang.
>
> xmzyshypnc <1002992920@qq.com> =E4=BA=8E2022=E5=B9=B49=E6=9C=884=E6=97=A5=
=E5=91=A8=E6=97=A5 20:32=E5=86=99=E9=81=93=EF=BC=9A
>>
>> There is a double-free security bug in split_2MB_gtt_entry.
>>
>> Here is a calling chain : ppgtt_populate_spt->ppgtt_populate_shadow_entr=
y->split_2MB_gtt_entry. If intel_gvt_dma_map_guest_page failed, it will cal=
l  ppgtt_invalidate_spt, which will finally call ppgtt_free_spt and kfree(s=
pt). But the caller does not notice that, and it will call ppgtt_free_spt a=
gain in error path.
>>
>> Fix this by returning the result of ppgtt_invalidate_spt to split_2MB_gt=
t_entry.
>>
>> Signed-off-by: Zheng Wang <1002992920@qq.com>
>> ---
>>  drivers/gpu/drm/i915/gvt/gtt.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/g=
tt.c
>> index ce0eb03709c3..9f14fded8c0c 100644
>> --- a/drivers/gpu/drm/i915/gvt/gtt.c
>> +++ b/drivers/gpu/drm/i915/gvt/gtt.c
>> @@ -1215,7 +1215,7 @@ static int split_2MB_gtt_entry(struct intel_vgpu *=
vgpu,
>>                 ret =3D intel_gvt_dma_map_guest_page(vgpu, start_gfn + s=
ub_index,
>>                                                    PAGE_SIZE, &dma_addr)=
;
>>                 if (ret) {
>> -                       ppgtt_invalidate_spt(spt);
>> +                       ret =3D ppgtt_invalidate_spt(spt);
>>                         return ret;
>>                 }
>>                 sub_se.val64 =3D se->val64;
>> --
>> 2.25.1
>>
