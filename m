Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C634EAF21
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 16:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237809AbiC2OUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 10:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237690AbiC2OUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 10:20:09 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4666B21AF
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 07:18:25 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id t40so7707156uad.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 07:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=cWmRjwSemdnUKvrif89Q11C8fxbCrVXCYfNEiZMLp48=;
        b=q2ewAGHIrHEqsse3MYwNWKox28h9JIed3X6fJpNooeICE1Kt4QtdQOImgpmeDWiSDc
         r7+GfcC5i1C0W0u3X9Hegeg6lo0HrkPB1k3KJvG9i+52dEOw+rqXOgFLeZh+476+iHVH
         Y+8TPyv1ihgnFjwC22yrT15foN2sQvk95rya+clZAxky0Tey7y4geNi38BXomndjxAfa
         Dzs30CbA5ePn8qJBzSd3Qjeqp4c4DPhTo3bxa4lHxgZ5AupOmpygDGqp+fFBuVyTZkWM
         cbhfNP+KdUgVwxB22SmF+7iJxaElkcb2heES2k3nFoZLXqweGhG7bUGLaAO+pkenHMhE
         1/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=cWmRjwSemdnUKvrif89Q11C8fxbCrVXCYfNEiZMLp48=;
        b=4yoFxc3+j0sTUahyMdpLM1KZnpIkZVWIGsy2eRV0p2k4YQxyRYkwYN7sAxl4wDTQAM
         zUsbvihVHIoe4epxAchKFf9KWw7Xn3c2M26hkS1hhwi7dsbSjPPNhjrn9sVvVLNh/6cq
         uoWPUAYnETTXq9kYyCCu5xQ0ham/KJDUf3tyRAoLgLG+xw10bE5e7hpg0XpQU921fBlO
         Z668sQv5oMeY05jfI5SIIndchGqegqX8DO95yCECn4/f+WHczVFrNYPqa9XlMJFG8EME
         zjMVuzJhTyAxjwrc29E31n2ondRjXVFDVw7FrWpQJ+4ihGa1FxConsDSz3oIkXFgO4zh
         i9vw==
X-Gm-Message-State: AOAM532DNvsRPAEM3mb3JqAyJEd/aUyf9oAEammWcWVKutm8RW4jL/Ep
        HxWBRzFrTmstlo6rAuh3emyvKeSe5liHL4CvONFxYFKF2sk4EnKt4VI=
X-Google-Smtp-Source: ABdhPJyCSCHgfeq1oXV2sIj9KyyT5a30IvRYPoptoOkpn8WaD3zTzGAa3H78hHjG8lRG4haLyJibn2W92CHDfMnD8sc=
X-Received: by 2002:ab0:44a3:0:b0:358:b93c:c9e6 with SMTP id
 n32-20020ab044a3000000b00358b93cc9e6mr16735235uan.81.1648563504023; Tue, 29
 Mar 2022 07:18:24 -0700 (PDT)
MIME-Version: 1.0
From:   Andrea Gelmini <andrea.gelmini@gmail.com>
Date:   Tue, 29 Mar 2022 16:18:07 +0200
Message-ID: <CAK-xaQb5epQjGCokTLc+vNrS_tp-8DVU3+poxn7WYX4eJaxTDA@mail.gmail.com>
Subject: UBSAN: array-index-out-of-bounds in megaraid_sas_fp.c (5.15.0 and 5.17.1)
To:     linux-kernel@vger.kernel.org
Cc:     yang.lee@linux.alibaba.com, bvanassche@acm.org, nitesh@redhat.com,
        martin.petersen@oracle.com, sumit.saxena@broadcom.com,
        jing.yangyang@zte.com.cn, colin.king@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,
   we use 12th, 13th and 14th generation Dell servers, Poweredge:
R720dx, R730dx and 740xd.

   The disk controllers are PERC: H710P, H730 mini, H730P.

   We are using Ubuntu 22.04 on these, without troubles, but at boot
we have a lot of these kind of complains, both with stock kernel of
the distro and 5.17.1 (precompiled downloaded from kernel.ubuntu.com).
So, it works, but I guess it's relevant for developers to see this:

dmesg.txt:[    2.241835] UBSAN: array-index-out-of-bounds in
/build/linux-CNGQTa/linux-5.15.0/drivers/scsi/megaraid/megaraid_sas_fp.c:103:32
dmesg.txt:[    2.252462] UBSAN: array-index-out-of-bounds in
/build/linux-CNGQTa/linux-5.15.0/drivers/scsi/megaraid/megaraid_sas_fp.c:103:32
dmesg.txt:[    2.317949]  ubsan_epilogue+0x9/0x45
dmesg.txt:[    2.317952]  __ubsan_handle_out_of_bounds.cold+0x44/0x49
dmesg.txt:[    2.339813] UBSAN: array-index-out-of-bounds in
/build/linux-CNGQTa/linux-5.15.0/drivers/scsi/megaraid/megaraid_sas_fp.c:115:31
dmesg.txt:[    2.361435]  ubsan_epilogue+0x9/0x45
dmesg.txt:[    2.361437]  __ubsan_handle_out_of_bounds.cold+0x44/0x49
dmesg.txt:[    2.394157] UBSAN: array-index-out-of-bounds in
/build/linux-CNGQTa/linux-5.15.0/drivers/scsi/megaraid/megaraid_sas_fp.c:125:9

   You can find all files related to these machines (dmesg, dmidecode,
and so on) organized by kernel, installation or liveCD, here:

    http://mail.gelma.net/PERC

Thanks a lot for your work,
Gelma
