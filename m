Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42ED553E62A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbiFFKNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbiFFKNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:13:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C64DE1796CF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 03:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654510151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WTpeojEBTrseUaMSVnCmShJgLb05X1O3wixL+XWUD1U=;
        b=R+3pSEakn3tLHgnX2OGUlBvGJmB/CWNt6iR1uk/oiUEVBT9yjVsuMfd6c4Nhyj5K46PrPo
        YoZUASmsiJNk4d35LmgTCi+4+OQOzQM+EpibmAW3VBsSfI0j59IAd7/oEMsweCMiOMper3
        lywArKI8m6nqqRPrU/ctTEI/ImS5BoE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-335-hb4uWvReOGazLolX28PdyQ-1; Mon, 06 Jun 2022 06:09:10 -0400
X-MC-Unique: hb4uWvReOGazLolX28PdyQ-1
Received: by mail-wm1-f69.google.com with SMTP id k5-20020a05600c0b4500b003941ca130f9so4963562wmr.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 03:09:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=WTpeojEBTrseUaMSVnCmShJgLb05X1O3wixL+XWUD1U=;
        b=n7om7TbaAqXFMZLi264/v2TSbFFcG2DMCCU4Xgn48+u1NhKBD8tZL4IMLrpul9Agmj
         LicEThmKAdBirDuAzKI6cfMr33QBEjHQ3mY0+wuoj9yGSo8Io6JpOFKR7jDhXEyxADoH
         4sJPMe6dGo+Wh82wmBppiUOTZoP/AlrW0D+paWneQMreiNLeIZOk8MLpCGoh+3+Lc/3Q
         0yjSVUdH2ChK0wVIQNM0UPU5j59TizgUvUWtGdMEJcdqv8OPdoaiYJjsN7OmdU0yAAFk
         fmVLWxOLgsBjZkE+11tDbVwLqfG2a3EXN46GaGprjQBrt2wBzOGZ9Ann1Lbj5/cRIMCb
         3kkA==
X-Gm-Message-State: AOAM531/mUI5mgQY8ocB9hclREE984bxr6siRKrmlUtXhMeM2ruWf2BG
        XnFSn7cMd1elQDfrZnH+a9DMl/ibXBR6SRqC/609nZax/DnLvyTs0vyYjgZ9tFW9xn1AfOb/Avv
        aMRqC3b5HPpUphUU5HCZ+qZYw
X-Received: by 2002:a5d:6651:0:b0:210:3e1c:1343 with SMTP id f17-20020a5d6651000000b002103e1c1343mr20795220wrw.137.1654510148490;
        Mon, 06 Jun 2022 03:09:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfuD0eMUP2v47G3d9f7pYllLF29ZboA6bfNKjPqw3VCslRaoPuPFtSStztMn0yQpS9t0z6uQ==
X-Received: by 2002:a5d:6651:0:b0:210:3e1c:1343 with SMTP id f17-20020a5d6651000000b002103e1c1343mr20795194wrw.137.1654510148287;
        Mon, 06 Jun 2022 03:09:08 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-112-184.dyn.eolo.it. [146.241.112.184])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c3b8500b0039c4e2ff7cfsm3344360wms.43.2022.06.06.03.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 03:09:07 -0700 (PDT)
Message-ID: <c8031ab902a2636d4badfe3fdff65930a1f2ac56.camel@redhat.com>
Subject: Re: [PATCH v3] selftests net: fix bpf build error
From:   Paolo Abeni <pabeni@redhat.com>
To:     Lina Wang <lina.wang@mediatek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Maciej enczykowski <maze@google.com>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Date:   Mon, 06 Jun 2022 12:09:06 +0200
In-Reply-To: <20220606064517.8175-1-lina.wang@mediatek.com>
References: <20220606064517.8175-1-lina.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-06-06 at 14:45 +0800, Lina Wang wrote:
> bpf_helpers.h has been moved to tools/lib/bpf since 5.10, so add more
> including path.
> 
> Fixes: edae34a3ed92 ("selftests net: add UDP GRO fraglist + bpf self-tests")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Lina Wang <lina.wang@mediatek.com>
> Acked-by: Song Liu <songliubraving@fb.com>

LGTM, thanks!

Acked-by: Paolo Abeni <pabeni@redhat.com>


