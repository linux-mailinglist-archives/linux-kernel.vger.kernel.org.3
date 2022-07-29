Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFED9584C22
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 08:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbiG2Gvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 02:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235032AbiG2Gvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 02:51:50 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A413180488;
        Thu, 28 Jul 2022 23:51:49 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id f7so4099301pjp.0;
        Thu, 28 Jul 2022 23:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cjhKGepMlIEO3Wci9/3Wr5ru3tWGJp3cNdIthSMySCg=;
        b=US94Ex6+mIhfte+TqRog+s2Pf22KJc6EgYEaPm3/yUsb6/+DYws4WaXhwOUT5GvYPQ
         V92T+XmW89JigEKPMhesf2sLNaIfs8njwK4lMudM73HLb2oWIyjgOLu+Al8k1NSGP3sw
         Bc4/TB99oOjibAFHntXUclE1OJ2BWuJKWeGHUQMHObXkXv/jBmkrQ2u35JwD6PJedTvW
         mF+0s7zreMnnXEDUKqVM+peME7l8ECifPSAItc7v4z312/oS8NX/SwCfsmg0BKohTB2m
         XL+ZKcgoW1ED9fh+9y6mnlckLOz/+aUnBt/952jo36p7b2lTrLCD2VDvr+bCXTtXg4bs
         avgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cjhKGepMlIEO3Wci9/3Wr5ru3tWGJp3cNdIthSMySCg=;
        b=721cc7L6fDjLqA0bo6S/9S996nR2jOeYlokyqai4Pr2pi6dpuncohfG+1XyIO2X8+H
         +bbzvtQj7BVhL2QrQd/2RcFLiarANUnbro1Cd1uNlq6m3umqPdgYEtCNZkLAsc8PzuNn
         X2QWpt1S2E4fU7tNLBixmyCZI4ZZlHERC4OO8XFuUHhqeKq1xm2IFscTraP2SQEZrZOx
         ths3a/Oxb32T7CaCyFocSed+LsqaeV1yVDnbcVC5tL8QvOQ5Xe5dwvAYoGPp3FQ2NApV
         JUva8w7MazMq97aOHuovLwE/Rf4WhR7nOP4ACwHAAGVecD3o95hpVALIdCZlGiBLUVfP
         R/3w==
X-Gm-Message-State: ACgBeo2VPXWpP+n69h41e/dboKYJBHR95+ZgSPd943XMtT6gK6BORSLH
        bRhjtGe5J4hsZRu90SO75IU=
X-Google-Smtp-Source: AA6agR5SdBo50/7T8qs90kIzI/XxNgQSSDqRotzuwp+Yc5ZycTaAJ2WsuqUnVJtlvvd/f4FflqW/6A==
X-Received: by 2002:a17:90b:33c6:b0:1f3:2434:29c6 with SMTP id lk6-20020a17090b33c600b001f3243429c6mr3322066pjb.70.1659077509104;
        Thu, 28 Jul 2022 23:51:49 -0700 (PDT)
Received: from fedora.. ([103.159.189.145])
        by smtp.gmail.com with ESMTPSA id mg20-20020a17090b371400b001f30b100e04sm4989301pjb.15.2022.07.28.23.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 23:51:48 -0700 (PDT)
From:   Khalid Masum <khalid.masum.92@gmail.com>
To:     syzbot <syzbot+14b0e8f3fd1612e35350@syzkaller.appspotmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: vmalloc-out-of-bounds Write in imageblit (2)
Date:   Fri, 29 Jul 2022 12:51:39 +0600
Message-Id: <20220729065139.6529-1-khalid.masum.92@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <000000000000bbdd0405d120c155@google.com>
References: <000000000000bbdd0405d120c155@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a simplified reproducer for the issue:

https://gist.githubusercontent.com/Labnann/923d6b9b3a19848fc129637b839b8a55/raw/a68271fcc724569735fe27f80817e561b3ff629a/reproducer.c


