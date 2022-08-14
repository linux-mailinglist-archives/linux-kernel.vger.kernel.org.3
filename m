Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CE95925B2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 19:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239709AbiHNRA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 13:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241340AbiHNQ7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 12:59:50 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A3D248E6;
        Sun, 14 Aug 2022 09:56:23 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id qn6so9982933ejc.11;
        Sun, 14 Aug 2022 09:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=3FPcPJtSj/bElkQiP9PnLcaKYbdRrJQOnxh5GM0k2J8=;
        b=jIhzROlIbZmReGLhU1yiB9ifnYNpK7wPMtsEhXldCXAgr8Rl8UiEDggdP71dGuTbS2
         vlO4HaLZtyD2uYq1DAk8mLwgDaeBSkNLaZkdvKKMyK7WzqdJQXz2vx6Xay0pd7Z7sDx1
         nsyUwCQiqqprl2sTAnh0An7a16wwTTiwXAEsyVymr4pYykSW49E1DE8uVt3MG/YM2vIp
         QsVf4SfoxVwN3OrtvQFfukbQg7QdjKv5I3P3bzFBSxC7qFPIVninGAyHPs/jVwHE5irt
         1f/knX5O8pcdB4DCux0gS+hCAGcEi+RbECkkWC0o6dh6HCEID2zNvPjwDehPQmrbb0Ie
         b1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=3FPcPJtSj/bElkQiP9PnLcaKYbdRrJQOnxh5GM0k2J8=;
        b=Li01OkcYXYSf57WzGPbsiAAJ30+R/4vCNVPBf/9HpXKHJJ8rUs/6CecDWZb+tth0em
         SupTCGuAQ8C7C9U7hozVLNz5vNvuLfsCXo2rDDTu1T8KT9i54NXAe9nwwkyuAijncJd2
         PN4Z2Y9+l7U3dr93APKGhAqOw+wSsDj9/zjqYAF8Z4sxYsWwXbuNGpa4z8yjf2dt0oqD
         /ngXITw6ywDjw+RqMez4XLrLIs9fqgKHw09ZGTL91DHOFCqwTX1AFmTs8KYb1byYnE5N
         pf1z+yToE47gCzvcavEVm6F1CBUt6Ic+sdVIXQwUZH3eWO/jxlmSnj/QV96KYTw2vfy+
         jH8A==
X-Gm-Message-State: ACgBeo3Rx407GcPCWQ4qkPkVU2f4vJx8w5q6bnYm9MgqF6SACBEBxa0V
        LZd2YOezvC059TGmNI2Kv4GBETxV/UG+SSLoSzQ=
X-Google-Smtp-Source: AA6agR4KRezlsVlNGcVNG12SydHF7/Af523+ZOD9iAijtLg+m6b2EPZib0GbeQ98ybmVhtVI16y8jh9PJCtnXHLMyzU=
X-Received: by 2002:a17:907:7241:b0:734:b282:184b with SMTP id
 ds1-20020a170907724100b00734b282184bmr8200009ejc.445.1660496181572; Sun, 14
 Aug 2022 09:56:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220802034729.2566787-1-haowenchao@huawei.com> <3ba71030-982b-c98b-78ee-ceca74da3b57@oracle.com>
In-Reply-To: <3ba71030-982b-c98b-78ee-ceca74da3b57@oracle.com>
From:   wenchao hao <haowenchao22@gmail.com>
Date:   Mon, 15 Aug 2022 00:56:10 +0800
Message-ID: <CAOptpSPLSbrQ8hgr275Ds7fwcBA_W9jYt0SFfhV-npPaz08S7g@mail.gmail.com>
Subject: Re: [PATCH v3] scsi: iscsi: Fix multiple iscsi session unbind event
 sent to userspace
To:     Mike Christie <michael.christie@oracle.com>
Cc:     Wenchao Hao <haowenchao@huawei.com>, Lee Duncan <lduncan@suse.com>,
        Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linfeilong@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 12:06 PM Mike Christie
<michael.christie@oracle.com> wrote:
>
> On 8/1/22 10:47 PM, Wenchao Hao wrote:
> > I found an issue that kernel would send ISCSI_KEVENT_UNBIND_SESSION
> > for multiple times which should be fixed.
> >
> > This patch introduce target_state in iscsi_cls_session to make
> > sure session would send only one ISCSI_KEVENT_UNBIND_SESSION.
> >
> > But this would break issue fixed in commit 13e60d3ba287 ("scsi: iscsi:
> > Report unbind session event when the target has been removed"). The issue
> > is iscsid died for any reason after it send unbind session to kernel, once
> > iscsid restart again, it loss kernel's ISCSI_KEVENT_UNBIND_SESSION event.
> >
> > Now kernel think iscsi_cls_session has already sent an
> > ISCSI_KEVENT_UNBIND_SESSION event and would not send it any more. Which
> > would cause userspace unable to logout. Actually the session is in
> > invalid state(it's target_id is INVALID), iscsid should not sync this
> > session in it's restart.
> >
> > So we need to check session's target state during iscsid restart,
> > if session is in unbound state, do not sync this session and perform
> > session teardown. It's reasonable because once a session is unbound, we
> > can not recover it any more(mainly because it's target id is INVALID)
> >
>
> I think we are ok now. Do you have a link to the userspace parts so
> I can make sure we have everything covered now?

I updated the PR on github: https://github.com/open-iscsi/open-iscsi/pull/339
