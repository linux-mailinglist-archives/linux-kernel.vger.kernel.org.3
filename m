Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D785A287C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 15:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344333AbiHZNZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 09:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344143AbiHZNZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 09:25:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE1F32DB8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 06:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661520337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UjS2O4t+aOXj1gb7edOnnQvwlSTlQg/GL0kaoQ1m9M4=;
        b=T3L0FyfCflQvmoe+uESQd1apELTT72ApsNWDc393KI6DJCgqUPoFloI2TYBL0u7WZn1FIm
        N6HdgHdlH/LjbBfq1WZOY67oZReqO+gouegWucQZlrTnTVh6iHqkzeBw1yPOIK8JIVX6b5
        gxbbWUcQLR+MtcmKS42rvJR7bPk9eF4=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-627-iQ1y5bU1ObScNbktccSJFg-1; Fri, 26 Aug 2022 09:25:35 -0400
X-MC-Unique: iQ1y5bU1ObScNbktccSJFg-1
Received: by mail-pg1-f198.google.com with SMTP id j3-20020a634a43000000b00429f2cb4a43so870738pgl.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 06:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=UjS2O4t+aOXj1gb7edOnnQvwlSTlQg/GL0kaoQ1m9M4=;
        b=16SPizIwTqAp64qjsZkO24KJejxXn1I5o6hPC31ZAQvBCVGKUkQgBCsXy3dQyJHFKX
         6Rp/m0mgWqLU8Dsemm9DdJ79ysyhhFARJKOP8zP32FYKYFppV7Fwxj2zqJNbRYJKS/OP
         i7qXs9RCZxAEzQ4o6TSIMDrjeNIXZ8nbuY7DXOfcGaqa5Eqbg9U8FzTB+CAHZnqN0GSM
         /ZGYdsKcNIjYDlRGlHgRqQkYjSkaGh6d1D44lAiI6K/PIXZJEylLh55dm48WY9qgK0+7
         7TvYtGYFwJYNIjWlkvQEgqSNtykfGazO/C77cshOZOzVyYdbZHbVUdOP1QACAQCzXhUF
         XNtA==
X-Gm-Message-State: ACgBeo2MGimNvhaecPQ57MWAM9EmWxIh0jFBm9+delccInpMt2OPjXCE
        kP4TQLdljFCb9eV+cobjPuVYuFQN/dkuKNAreXSF/vHHLBNkcEB0Jm6bPxPx+W6HjbdXq0C7A7A
        2s69zNuSJfgMuQ6QYmRUaalsavk0b7IJ6okYMNzc/
X-Received: by 2002:a63:211:0:b0:41d:946e:cf67 with SMTP id 17-20020a630211000000b0041d946ecf67mr3282525pgc.497.1661520334774;
        Fri, 26 Aug 2022 06:25:34 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6xF4GijyT5YL/pHPs7RpNbVVqlsP2T8W1Gp6jh2yfBYGlopFWShAPPxbyWTf9KT9uLezlA+a+vOIoAuLpweWo=
X-Received: by 2002:a63:211:0:b0:41d:946e:cf67 with SMTP id
 17-20020a630211000000b0041d946ecf67mr3282504pgc.497.1661520334523; Fri, 26
 Aug 2022 06:25:34 -0700 (PDT)
MIME-Version: 1.0
References: <AFQA3gCKFKPruj6DtSI6oaqd.1.1661219001658.Hmail.3014218099@tju.edu.cn>
In-Reply-To: <AFQA3gCKFKPruj6DtSI6oaqd.1.1661219001658.Hmail.3014218099@tju.edu.cn>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Fri, 26 Aug 2022 15:25:23 +0200
Message-ID: <CAHc6FU44=yMSq2FHzumL+Fe7x63qgMYt5Xtw5ctwB7dRG09mEQ@mail.gmail.com>
Subject: Re: kernel BUG in gfs2_fill_super
To:     =?UTF-8?B?546L5rW35byb?= <wanghaichi@tju.edu.cn>
Cc:     cluster-devel@redhat.com, rpeterso@redhat.com,
        linux-kernel@vger.kernel.org, lishuochuan@tju.edu.cn,
        syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 3:52 AM =E7=8E=8B=E6=B5=B7=E5=BC=9B <wanghaichi@tju=
.edu.cn> wrote:
> Dear Linux maintainers and reviewers:
>
> We would like to report a linux kernel bug, found by a modified version o=
f syzkaller.
>
> May affected file: fs/gfs2/ops_fstype.c

Thank you.

Andreas

