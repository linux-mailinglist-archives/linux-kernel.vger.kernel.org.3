Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B8B54390D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245611AbiFHQ3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245295AbiFHQ2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:28:12 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E9D1FE38D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 09:28:10 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id y19so42506584ejq.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 09:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eIhsgd4qYNDkbHY1tSv0TAemIX3YjvX24oBE2vbHP9s=;
        b=q4REp7vJNJCw7clXuyO3mj6Yi54h3u6xe9uA3nbJ7FWErSDyW4H4FiTzxAwD0uUZfU
         rM924OIqUo+ecqazXEQwTxo+pevPbqJkO9lGWVq5e/0lsQqp22kxsIvtP8o6qNm634vW
         X0DbF/nhg27S6az45V0JockL4wwUZfeyuqgtJxh2Xxdt0cCaVja+9kvo65UabcSX5tpZ
         gLP9dg8RJTj9bATBOqu8pPNaiU8gU4vnbbeee+YPxkPXmVLr9Lup+z7NX+sU6VNyWCyO
         ZULLu7dAJgWnt83TgddQryzx6212MqNGHCytA+99L5FYm9kT+DdlwLqlTwxq6/cP3Gol
         s5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eIhsgd4qYNDkbHY1tSv0TAemIX3YjvX24oBE2vbHP9s=;
        b=pzs2Yl4nXlEH17rldc5omaBmZzFSTKq8KO5C30APhCm9RvH0Z9YN/wbGmA5PFxxxBc
         4v4XEHshgWFlxpjwPQMNmTlhsHD0ua2/6CFZAOApWYcMbj+YEwXWOLErJqugCWJylarz
         dMZvHN1avgH8mCvdWBn0W749FYnah85Sc/3IWrgmfk9OU/NyB3OAm2BwICr385BcVeJP
         H0rH5QvjplK6HDzFqPB6aN7xLYSl3rPepXsVLdpqTg5AQne3R8tw5lbgt7mpwNjqycNY
         ov5V7tvkL/Nh4BkdYzxYHALviUo+vqOPnhPc+MUJSPhxSNb0XKTH/EEiRmpDQ30dDT8F
         h63w==
X-Gm-Message-State: AOAM533RnvoOA1FYxe8kf5Zs2CjJyqUyO9F6CyMiZJrrmd31Fv+HrIKc
        VC8HdK06cqgd1SyAlkC5VG5udxNGbTnZTMXFUJ51m5C0uGv2xmHY
X-Google-Smtp-Source: ABdhPJwolD3lZVOpmYDr6xc0CANuwgDbVNbFIRuxCneLZAsPrI7uHQlv2+r6I1IBzQ0EaNTcNvqAO1MHwml1IL9yCKU=
X-Received: by 2002:a17:907:1ca8:b0:70c:68ce:dade with SMTP id
 nb40-20020a1709071ca800b0070c68cedademr29501960ejc.723.1654705688387; Wed, 08
 Jun 2022 09:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220608110734.2928245-1-tzungbi@kernel.org> <20220608110734.2928245-19-tzungbi@kernel.org>
 <CABXOdTdPwO6xv+DPcErZJcqZsLMMECcuk5MEYEpf4L3PYhSh7g@mail.gmail.com>
In-Reply-To: <CABXOdTdPwO6xv+DPcErZJcqZsLMMECcuk5MEYEpf4L3PYhSh7g@mail.gmail.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 8 Jun 2022 09:27:57 -0700
Message-ID: <CABXOdTe_tG2e3MK=d6ZWggjj_=iYn7BFjhGOvOJBJ1JASx3NEw@mail.gmail.com>
Subject: Re: [PATCH v3 18/23] platform/chrome: cros_ec_proto: check
 `msg->result` in getting cmd mask
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:CHROME HARDWARE PLATFORM SUPPORT" 
        <chrome-platform@lists.linux.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 8, 2022 at 9:23 AM Guenter Roeck <groeck@google.com> wrote:
>
> On Wed, Jun 8, 2022 at 4:08 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> >
> > cros_ec_get_host_command_version_mask() should check if EC wasn't happy
> > by checking `msg->result`.
> >
> > Use cros_ec_map_error() and return the error code if any.
> >
> > Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> > ---
> > No v2.  New and separated from the original series.
> >
> >  drivers/platform/chrome/cros_ec_proto.c | 21 +++++++++++++--------
> >  1 file changed, 13 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> > index 06bc7db1213e..6a5771361383 100644
> > --- a/drivers/platform/chrome/cros_ec_proto.c
> > +++ b/drivers/platform/chrome/cros_ec_proto.c
> > @@ -428,13 +428,12 @@ static int cros_ec_get_proto_info_legacy(struct cros_ec_device *ec_dev)
> >   * the caller has ec_dev->lock mutex or the caller knows there is
> >   * no other command in progress.
> >   */
> > -static int cros_ec_get_host_command_version_mask(struct cros_ec_device *ec_dev,
> > -       u16 cmd, u32 *mask)
> > +static int cros_ec_get_host_command_version_mask(struct cros_ec_device *ec_dev, u16 cmd, u32 *mask)
> >  {
> >         struct ec_params_get_cmd_versions *pver;
> >         struct ec_response_get_cmd_versions *rver;
> >         struct cros_ec_command *msg;
> > -       int ret;
> > +       int ret, mapped;
> >
> >         msg = kmalloc(sizeof(*msg) + max(sizeof(*rver), sizeof(*pver)),
> >                       GFP_KERNEL);
> > @@ -450,14 +449,20 @@ static int cros_ec_get_host_command_version_mask(struct cros_ec_device *ec_dev,
> >         pver->cmd = cmd;
> >
> >         ret = send_command(ec_dev, msg);
> > -       if (ret > 0) {
> > -               rver = (struct ec_response_get_cmd_versions *)msg->data;
> > -               *mask = rver->version_mask;
> > -               ret = 0;
> > +       if (ret < 0)
> > +               goto exit;
> > +
> > +       mapped = cros_ec_map_error(msg->result);
> > +       if (mapped) {
> > +               ret = mapped;
> > +               goto exit;
> >         }
> >
> What if ret == 0 ? Is that valid ?
>

Never mind, addressed in a follow-up patch.

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> Thanks,
> Guenter
>
> > +       rver = (struct ec_response_get_cmd_versions *)msg->data;
> > +       *mask = rver->version_mask;
> > +       ret = 0;
> > +exit:
> >         kfree(msg);
> > -
> >         return ret;
> >  }
> >
> > --
> > 2.36.1.255.ge46751e96f-goog
> >
