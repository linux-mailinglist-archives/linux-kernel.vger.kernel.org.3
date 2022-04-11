Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BFC4FC654
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 23:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237036AbiDKVKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 17:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiDKVKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 17:10:33 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39242AC79;
        Mon, 11 Apr 2022 14:08:17 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id b19so24802746wrh.11;
        Mon, 11 Apr 2022 14:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=cuLSn1q/GBIKSgoYE18mr+8Xjjh5E8wzIDAnZC3Kor4=;
        b=hYlw6pRtzMxtWsAkiIgcWRN+12HL1xIob5XMpA/zejat696Pcxo2DTP/KTwXMKS5vc
         AYM9+XGhuKlU7EDDi1uqFnQu2pOwhlsxi8Oeo5eht/OrbJqKU5dIe58xJaUA8X8yQbu8
         PR7Qokl1dStZXC5NNgVAu3P6fnvTw99NVCzlCUbUvvQVVs337EylT+eOp82FHHa+zVMv
         yFl2NMF+vdPZdVdTIok+zCLZjhXPyHEwKiUjmbxz/FNoWnxVDRczfXn2Z3VqZLANRnY9
         xM/N3XpVqA7Qv2xRTZEmiK4Wi/3eKNG2M/huJi7rS2Qd/FCzAifUKrzhrQ47KIHXn2vf
         2dow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=cuLSn1q/GBIKSgoYE18mr+8Xjjh5E8wzIDAnZC3Kor4=;
        b=vuXmHHnGbVb1cjQxtEa0XBoYXrx8To/0vuOawE8Lq5+eBPvTyKz4t1I7Qylns8SOEM
         h34ZA6U3O+yuNHjXSxaJsMU0p9YiozJ1hAuLJiFKkVhR5RL4dDGsP+MRUl3O5jBOVCm1
         wJ29+8+JXO6KftL8XGEhQsDyqo7NgcBYVI675692RnfTuZ4XXIiviksKGK72vhQUVzD6
         xcEukZC4361+QFloRZ0jpPLCri92kGq2c6KNXF3WsAJlzWScpNQqMWDGmdJcoa8fPtem
         cPyCIVwec1//egV6Ks/dAk+s7gN4Osxlm/MHZH+yPzgsykOUzFp77jCN+8VLSYcn++tj
         qwbQ==
X-Gm-Message-State: AOAM533IiD/0OB6UpsM7UpxtJW6O+oTum4fF6Z8sS/37+ICUz8p9+aPn
        QsoXdnMnI6ynZxmE+ejcLyU=
X-Google-Smtp-Source: ABdhPJz/VITA/P7SQx1zn0TZYnR++acV4H+Y3dJMoss7AHPZDuvdhr4i36KcTLujykxZPwaT/jxkPg==
X-Received: by 2002:adf:eb4d:0:b0:1ed:c1f7:a951 with SMTP id u13-20020adfeb4d000000b001edc1f7a951mr26150009wrn.454.1649711296330;
        Mon, 11 Apr 2022 14:08:16 -0700 (PDT)
Received: from nz.home (host81-147-8-147.range81-147.btcentralplus.com. [81.147.8.147])
        by smtp.gmail.com with ESMTPSA id 3-20020a5d47a3000000b0020412ba45f6sm32624942wrb.8.2022.04.11.14.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 14:08:15 -0700 (PDT)
Received: by nz.home (Postfix, from userid 1000)
        id 300222C6C320B; Mon, 11 Apr 2022 22:08:15 +0100 (BST)
Date:   Mon, 11 Apr 2022 22:08:15 +0100
From:   Sergei Trofimovich <slyich@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     amd-gfx@lists.freedesktop.org, Joe Perches <joe@perches.com>,
        linux-kbuild@vger.kernel.org, Jakub Jelinek <jakub@redhat.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: gcc inserts __builtin_popcount, causes 'modpost: "__popcountdi2" ...
 amdgpu.ko] undefined'
Message-ID: <YlSYv3d9a5cZR9KE@nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current linux-5.17.1 on fresh gcc-12 fails to build with errors like:

    ERROR: modpost: "__popcountdi2" [drivers/net/ethernet/broadcom/bnx2x/bnx2x.ko] undefined!
    ERROR: modpost: "__popcountdi2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!

It is occasionally seen by others on previous gcc versions as well:

    https://lkml.org/lkml/2021/7/11/261
    https://lkml.org/lkml/2018/10/24/403

'__popcountdi2' are inserted by gcc for code like the following
from 'drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c':

    static inline enum mod_hdcp_status validate_bksv(struct mod_hdcp *hdcp)
    {
        uint64_t n = 0;
        uint8_t count = 0;
        u8 bksv[sizeof(n)] = { };

        memcpy(bksv, hdcp->auth.msg.hdcp1.bksv, sizeof(hdcp->auth.msg.hdcp1.bksv));
        n = *(uint64_t *)bksv;

        /* Here gcc inserts 'count = __builtin_popcount(n);' */
        while (n) {
                count++;
                n &= (n - 1);
        }

        return (count == 20) ? MOD_HDCP_STATUS_SUCCESS :
                               MOD_HDCP_STATUS_HDCP1_INVALID_BKSV;
    }

Note that gcc can insert it regardless of -mno-* options.

How should linux.git handle it? A few options come to mind:

- Perhaps use libgcc.a directly.
- Just implement '__popcountdi2'. Example definition from libgcc:
  https://gcc.gnu.org/git/?p=gcc.git;a=blob;f=libgcc/libgcc2.c;hb=HEAD#l846
- Or workaround it with -fno-builtin-popcount in Makefiles.

CCing people who can help routing it and/or deciding on the fix:
amd-gfx@lists.freedesktop.org, Joe Perches, linux-kbuild@vger.kernel.org,
Jakub Jelinek, Segher Boessenkool, Thomas Gleixner,Peter Zijlstra, Andy
Lutomirski.

WDYT?

Thanks!

-- 

  Sergei
