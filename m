Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECD65279B1
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 22:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238536AbiEOUB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 16:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiEOUBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 16:01:24 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C3C108A
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 13:01:22 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id t25so15939133ljd.6
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 13:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gp1BBNbZ42X2QQArBCdHGs3vRj6i0vfmgJdrQAenEi8=;
        b=KaYlgWABpd6a3tNDr5IgU145YKsThgKBIjyTd4jrNPrzi2nb1bueC3Xy82RlkV9vQ/
         yOBRpZnEHtedYLPJ05sfQjJWeWLP2iLHEMC+vqAB16psAn+GkZYuoZVNijh+EmbB87oh
         KKt8qa++8sziMV5BFeFPUcrISPtqGsonKj4ouLj8xshJgmU2jS3aQagGgK/rUyUqBxEI
         q7mpIexGUZJ+DsYkDYQvkOxvMmvrxCz3LzxViPIoRZRGejSyIW5WH1BiZQGdbI2DRgQL
         NwgkQI6o3P+lAn0Pm6t5WghxFjGcSiOHcu6uCll+BpgLq2V57kjcXdwyFEAUV09fw1rz
         nO9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gp1BBNbZ42X2QQArBCdHGs3vRj6i0vfmgJdrQAenEi8=;
        b=rWmMwM1S77oTu0mcU9LVacdN/1RL3BXzgPflDFigrUFPBX+5nZ7SIcnRfFQYl/znd7
         urEMGJoNkY85EmFUXQ0gWkY0JAE4hqIbQdRAwMxbxZr8+zVwXyaBoKaLxODSuG30DyGY
         qI065ztSCt3e8Ve3kb2wT+9og8aV4a50M1LMYd4n5HIbf1z5iuNxGvIiQJOV60pcHEBY
         lXRrMfOKxLdwczLK9cj93Pegu90/HpsEb0rF6+7CUd46fdFXJgQ3I3iczFbbFESU0iI9
         Y5hCcRBXcfZk3FW3AdVAnF18LWYv4LCunUJC71Ng+ZlJL5GPWtxdKBJ3UmZWA69GJPCv
         QeTw==
X-Gm-Message-State: AOAM531rfB/Dz+6eYsoJwPL+liZVHPuyQMqHzn5mv54HPpLl4w+4VEW6
        wGdu5JCqEgAaWToRozmvmTg=
X-Google-Smtp-Source: ABdhPJwOSzSWFgoL3e9QR6GHMUfWEHBZOf7c/bjyfVeBDKmOZCSFVEDUldjICnUZ5ADXEnxg9cHzCw==
X-Received: by 2002:a05:651c:1077:b0:24f:10fb:5d80 with SMTP id y23-20020a05651c107700b0024f10fb5d80mr9515287ljm.207.1652644880593;
        Sun, 15 May 2022 13:01:20 -0700 (PDT)
Received: from localhost ([178.170.168.3])
        by smtp.gmail.com with ESMTPSA id b18-20020a056512219200b0047255d210f9sm1099424lft.40.2022.05.15.13.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 13:01:20 -0700 (PDT)
From:   Maxim Zhukov <crazycdeveloper@gmail.com>
X-Google-Original-From: Maxim Zhukov <mussitantesmortem@gmail.com>
To:     chi.minghao@zte.com.cn, varad.gautam@suse.com, arnd@arndb.de
Cc:     akpm@linux-foundation.org, shakeelb@google.com,
        vasily.averin@linux.dev, manfred@colorfullife.com, dbueso@suse.de,
        linux-kernel@vger.kernel.org,
        Maxim Zhukov <mussitantesmortem@gmail.com>
Subject: [RFC PATCH 0/1] Fix handling semctl on x86-32 kernels
Date:   Sun, 15 May 2022 23:01:02 +0300
Message-Id: <20220515200103.1408370-1-mussitantesmortem@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure about this patch. Maybe there is a better way to solve this problem:
all libc sends with cmd IPC_64 flag[1][2][3], but x86-32 kernel does not have compat
syscall layer to handle correctly semctl command.

[1]: https://elixir.bootlin.com/uclibc-ng/v1.0.40/source/libc/misc/sysvipc/sem.c#L58
[2]: https://elixir.bootlin.com/musl/v1.2.3/source/src/ipc/semctl.c#L48 -> https://elixir.bootlin.com/musl/v1.2.3/source/src/ipc/ipc.h#L22
[3]: https://elixir.bootlin.com/glibc/glibc-2.35/source/sysdeps/unix/sysv/linux/semctl.c#L124

Maxim Zhukov (1):
  ipc, sem: fix backward compatibility with x86-32 kernels

 ipc/sem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.36.1

