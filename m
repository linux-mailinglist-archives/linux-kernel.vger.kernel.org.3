Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DF05A67AD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 17:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiH3Prv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 11:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiH3Prs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 11:47:48 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8948DB075
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 08:47:47 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id c4so9573080iof.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 08:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=9f2bO9sEBdq+wgciheHTKF7TZKiz92E+7DCQ/5qexd0=;
        b=hbufoTwEPykpa51OHC80c1lNeHDkPA9Syp/0nviAloJ905gGMGBophKG498BPZGv0g
         xN7wqPhyjGhJ6x/9aWVh0LFYBT6YB/GustCVXqbxObHu3yKIXR2NjGKpcjuXII6wIrQ6
         cEpQZ/2nb7f/UbVFFeBpheb9gb7G8k6uanF60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=9f2bO9sEBdq+wgciheHTKF7TZKiz92E+7DCQ/5qexd0=;
        b=hgu9deQpNnyu/r82Zf4N+CIZzFGe88OdjC3VuQ4TPVMmND6FBCP25SNosREASuNNys
         MVKtV0CL4jINvBF/ufm0ZDuxX4pf46XvJT7yw8ijGH7M32fieCxyznxigmJCduipVbj7
         LZ4Zz5dqfxSNNjVw2AkWhYkLGoFVK+ZtRdwv4NF4jySZeEciQxLGH9k3penLelTSOVXP
         KWpUF6q454eTN3t+RBoLkCab/SXLk4Zg7XKx3++0F84jTwGcNh+AhuwKooZ+wLH6GB40
         c4bqSi/RGOzY77cDvG7IgZtmkKMiMbde7lgtSkhDVtpjJ009rEg/Y+4AMrDW1AC3cXZD
         msag==
X-Gm-Message-State: ACgBeo1/w3rPCThHuQ4iW7d7M+OdBPul2u9fE8Lxrz+Fb8YU5UBUy8zh
        uvvcsVYEYpiXIASYzmonCDh1Jqlwqsal3XoL
X-Google-Smtp-Source: AA6agR42vSJXPvk7cqInlw7rKfSYLubbX+uOw8wlmFUMsGIrZaYZAELJxP+cvh4beJ3lMzjLOKnpEQ==
X-Received: by 2002:a05:6638:160a:b0:349:d991:d929 with SMTP id x10-20020a056638160a00b00349d991d929mr13699910jas.144.1661874466785;
        Tue, 30 Aug 2022 08:47:46 -0700 (PDT)
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com. [209.85.166.176])
        by smtp.gmail.com with ESMTPSA id c12-20020a02960c000000b0034277c336b0sm5733448jai.58.2022.08.30.08.47.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 08:47:45 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id t11so3280278ilf.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 08:47:45 -0700 (PDT)
X-Received: by 2002:a05:6e02:1789:b0:2ea:ccd4:d0ed with SMTP id
 y9-20020a056e02178900b002eaccd4d0edmr7210776ilu.177.1661874465309; Tue, 30
 Aug 2022 08:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220822105340.1.I66a9a5577f9b0af66492ef13c47bc78ed85e5d6b@changeid>
 <YwjhxQjiJeQ0u5rh@ravnborg.org>
In-Reply-To: <YwjhxQjiJeQ0u5rh@ravnborg.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 30 Aug 2022 08:47:31 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U+2OJzXvkXKbvm=veJeoxpHs_sHhs-maNGCWjPowCeJQ@mail.gmail.com>
Message-ID: <CAD=FV=U+2OJzXvkXKbvm=veJeoxpHs_sHhs-maNGCWjPowCeJQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add myself as a reviewer for panel-edp.c
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 26, 2022 at 8:07 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> On Mon, Aug 22, 2022 at 10:53:59AM -0700, Douglas Anderson wrote:
> > panel-edp changes go through the drm-misc tree (as per the "DRM PANEL
> > DRIVERS" entry in MAINTAINERS), but ever since splitting panel-edp out
> > of panel-simple I've been trying to keep a close eye on it. Make that
> > official by listing me as a reviewer.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>

Pushed with Sam's ack.

e6545831a17b MAINTAINERS: Add myself as a reviewer for panel-edp.c

-Doug
