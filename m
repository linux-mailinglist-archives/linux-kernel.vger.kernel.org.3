Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF91573FA4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 00:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237148AbiGMWcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 18:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237056AbiGMWco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 18:32:44 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6F64D81D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 15:32:43 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 89-20020a17090a09e200b001ef7638e536so6071699pjo.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 15:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IC9WGNm/k/HKk/gJGNaIvhPEN6uro4h2Di4XSx0/wSo=;
        b=OkSo1h56KPB5dkuCz8RIEJrgSYw4gI07VeoymulEGnmJB6DcrjGkznYuVr404v6pt+
         9yHloAN4Q07BaVh71sQpHnPVZNumFT7r5SE3nqXAUTn0roPwGbrTLVS9ahctp1L8a+rq
         0eps4wB9X7CAyqmAtmPUpchkdoEpFGHoNamrQl92nN/VEKkskeKEDPMM0ofVu6bqmp9D
         2WLtOCI3Q6SNyOM4dA8/xuE/qSWNruUPJy1Pd8wbmIy4yw30BUz+lSMl86wtaz1GIOv1
         /EpmiXBWNYnqo1hSvyQOIr7nXZT4xJ3AtRU6/rs7O09UaEfzBGIULZcvMZkk9pmQufia
         S4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IC9WGNm/k/HKk/gJGNaIvhPEN6uro4h2Di4XSx0/wSo=;
        b=7rLhhJlC5fN94jeZf83HpHOOytlTPI3cMUoLwybegGmqjRHCzApvTl1Pv1iUA31JS8
         fmv0F0M5izvlpBLGavg7jN/IklV/LDrovHyzZnP+KFVo3t33jVTUYuJ6+HncVwv+4ka8
         eMCXZHub080wIEHcyDIyFtlsyWbFRJ9bE77Z68ZC8N8ZRx86ETOszcAxh222QGHJiOXq
         EuCy51RoO7rt92x8wFk8gQvdHHPArnbE8oBW/VDThAhdpWre81BxbRS8//A0v8ufkVxT
         kum+ndYV+W5BTbhPJ93jxpHu/B5SzitzFQ11Ej5s3tg1/qezjVsS/PQq3HseZugVuxND
         AjIA==
X-Gm-Message-State: AJIora+O2atyG1hMc3vDalx83QGOv3so3c/d3fRqLcJV/lVK4fw5ZTkE
        ICGIYuFNPJ/jaS21AsjhCqYAFg==
X-Google-Smtp-Source: AGRyM1uM2JXWmZ+X73tly9ctALwOfHOQQW2AF5qxNd9TwdS/gxM4q6HbjbNoMiJYW+NrmS56kvEVZg==
X-Received: by 2002:a17:902:c409:b0:16c:10a2:afa8 with SMTP id k9-20020a170902c40900b0016c10a2afa8mr5250538plk.105.1657751563227;
        Wed, 13 Jul 2022 15:32:43 -0700 (PDT)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id i15-20020aa796ef000000b00528c6c7bf37sm43808pfq.129.2022.07.13.15.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 15:32:42 -0700 (PDT)
Date:   Wed, 13 Jul 2022 22:32:37 +0000
From:   Joe Burton <jevburton@google.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Joe Burton <jevburton.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] libbpf: Add bpf_map__set_name()
Message-ID: <Ys9IBYKqlTzkf3jA@google.com>
References: <20220713214246.2545204-1-jevburton.kernel@gmail.com>
 <CAKH8qBtkgsQ9snhno3aYnhyc8vG2a0xhgg_sCb4KFhcQt+gfqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKH8qBtkgsQ9snhno3aYnhyc8vG2a0xhgg_sCb4KFhcQt+gfqA@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Asked you internally, but not sure I follow. Can you share more on why
> the following won't fix it for us:
> 
> https://lore.kernel.org/bpf/OSZP286MB1725CEA1C95C5CB8E7CCC53FB8869@OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM/
> 
> ?
> 
> The idea seems to be to get the supplied map name (from the obj)
> instead of using pin name? So why is it not enough?

You're correct, this approach also resolves the issue. No need for this
new API.
