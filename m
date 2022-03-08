Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929E84D1520
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 11:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345988AbiCHKuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 05:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239485AbiCHKuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:50:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D42E3DA51
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 02:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646736556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QBUaBHFVFzH61kttRw3vU/TxfXeStTkYl0GPKGc8WcE=;
        b=FBsTD/0XVrm4ydtsvWV7itkOZQcR2oASCIXTu9tk0heQJ572TU++TKPicrX+joSkcbyc5u
        iGnljwSkpwMBd3IDHdgVkLPn2CbrTyjDkRRMUS1Nh+TbXTIg9JZVMyuEz+uvmJOcNSHqy7
        HgA7LaUrRMYQx6xlpEi+PbvaKT4xk+k=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-501-lYnjH-GAO9iYhx-CI8xZGg-1; Tue, 08 Mar 2022 05:49:13 -0500
X-MC-Unique: lYnjH-GAO9iYhx-CI8xZGg-1
Received: by mail-qk1-f198.google.com with SMTP id i189-20020a3786c6000000b00646d7b30998so13891716qkd.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 02:49:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=QBUaBHFVFzH61kttRw3vU/TxfXeStTkYl0GPKGc8WcE=;
        b=Q9zwu2SMlvGyautKaVuXeswQ0eNcg8QPAJh+0w4vmTG+KLNOTWaFWyje8GP/O4/imJ
         XAS4UWX/ucCON2QRLw9x3nmXuUT7awria1iAutsEbiT9IgSq+NuDx1oJ0wRZ/5pH+kmV
         Zc9v1abCT2N988tm20AVpJb3Cd9aFNUkmUvs8ctSVwY8R2sVAA1epdDoB4l4EjDM52QP
         yzPYdOQUvJCyWzZq4KjtHkfsU47w+YbcctnkKDqEFbcA1P9esngMVdeEZ4x0c5Vj/I6E
         ex+U6S+Yv/XgcxPe+ocaybzwlZZVgIREczi24sGiFUt385EDeq/XUqlzoKgf+XF4xtRC
         cG0Q==
X-Gm-Message-State: AOAM531Wu88xg7D+7oYPs0QNVz525cufPJZgBHYn+RwM+59KZsp4ES0j
        JKodcuICFD6TuB6ezhhceCdfem+djSmFhBf3QLiqr430AGRCvAxjuUUr49SKYz8G4yvjzycy2Vv
        iptOAQMq7+B96punog9NlC1kh
X-Received: by 2002:a05:6214:2a4a:b0:435:8b63:ecfb with SMTP id jf10-20020a0562142a4a00b004358b63ecfbmr7485980qvb.44.1646736552970;
        Tue, 08 Mar 2022 02:49:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwpx3hIh+39H8UxjxhPinjAfhfXTwNPWavYyQ9aJfYLnuOb+72k+PF5hHSRGOgfL6XqVEiAdA==
X-Received: by 2002:a05:6214:2a4a:b0:435:8b63:ecfb with SMTP id jf10-20020a0562142a4a00b004358b63ecfbmr7485967qvb.44.1646736552733;
        Tue, 08 Mar 2022 02:49:12 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-232-135.dyn.eolo.it. [146.241.232.135])
        by smtp.gmail.com with ESMTPSA id p16-20020a05620a22b000b0067b7b158985sm1311776qkh.128.2022.03.08.02.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 02:49:12 -0800 (PST)
Message-ID: <38c7c77ee46ed54319b7222c2fada0039a980a2e.camel@redhat.com>
Subject: Re: [PATCH] drivers: vxlan: fix returnvar.cocci warning
From:   Paolo Abeni <pabeni@redhat.com>
To:     Guo Zhengkui <guozhengkui@vivo.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Roopa Prabhu <roopa@nvidia.com>,
        Eric Dumazet <edumazet@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     zhengkui_guo@outlook.com
Date:   Tue, 08 Mar 2022 11:49:08 +0100
In-Reply-To: <20220308100034.29035-1-guozhengkui@vivo.com>
References: <20220308100034.29035-1-guozhengkui@vivo.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, 2022-03-08 at 18:00 +0800, Guo Zhengkui wrote:
> Fix the following coccicheck warning:
> 
> drivers/net/vxlan/vxlan_core.c:2995:5-8:
> Unneeded variable: "ret". Return "0" on line 3004.
> 
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>

Please specify a target tree (likely net-next) in the patch subj.
Additionally, this looks worthy a "Fixes" tag, likely:

Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata device")

Thanks,

Paolo

