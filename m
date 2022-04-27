Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC599511121
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 08:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358110AbiD0G3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 02:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358104AbiD0G3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 02:29:40 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFF1B42DD
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:26:28 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id j8so719583pll.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=1bS4Q9BDlM4oKoEfSPn3EHiefcBS79HtqoMdoht7vK0=;
        b=QZuSSbCznjyNlIhqARAeg5mud9WOt9skLpAWVkm2UGhfmIC0Li7mfItET7ZriUPIZb
         3c5By4jupRCP7P28/GarVVxiOwDAncJq/1G5mwk+Wke7T3Scd3uyZhOMqk0JYidzr5sQ
         kx1k5yffxCtLdumT4bDi28Y5ofJfkz1ZlnzZ6JWbNTwci6Vc5aEzaAAKgUxNeRdjC2Nd
         dK+JGPQ88DdMEvgbrRwJR3VfJyzMPbIFwxGnLJAzh8Pef7zmBQMo59EUuVTTg5KQAu6U
         lB/PoCofMrWG9oVNQjwLH13SS1x5lJdX+zJdbxnNYoDbNS0heYJb8nRf+dVHWSvUpegp
         PDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=1bS4Q9BDlM4oKoEfSPn3EHiefcBS79HtqoMdoht7vK0=;
        b=yuobsZSIeN2E8Vo+r2gOM4RqM1q9gs4E7Pc3nHd8U0GxJUJsosZHlUJ75qE1LUC97Z
         b5g30fMvY+dOd3X4e6pDw43kElsqN+4j9Wvvxa5skxkMkRzLuFYIZvB2yR69Bthav1ZH
         6iA9pkapOV4lM20on5jlpvopRGXRIjFCIwDxZQYFii7c4brJ9V/Ytb+BifXSbPchCSXe
         cceRkuJOGA0pC/nYVRlkaaG+e/Tt/6q8vGCWjzKdbnDN7+f3wN7pwHecnkKgQadwHzow
         5tP98JDs2DoOx8Oit0IPZElyIc450upX8yFC3vT4UAYnAJIdouvWrVL2+k+yPozXSy/x
         kgXA==
X-Gm-Message-State: AOAM533tXSJNoy1YZjh/wEYL6Ij6oePIpvLNbqpzp8OHLOfcAa7K4Y0A
        MvlFkv2xT+IS79K4H4B9SgM=
X-Google-Smtp-Source: ABdhPJwWUEiRdSfDzwKl4HWGWj9HdFQ4dMBWskekMIfPKAtY3AcvDCjrsae0Q889quYNnRqAXe9LSQ==
X-Received: by 2002:a17:902:ea0d:b0:15c:eceb:de38 with SMTP id s13-20020a170902ea0d00b0015cecebde38mr19572260plg.37.1651040788382;
        Tue, 26 Apr 2022 23:26:28 -0700 (PDT)
Received: from localhost (subs28-116-206-12-32.three.co.id. [116.206.12.32])
        by smtp.gmail.com with ESMTPSA id p2-20020a634202000000b003a0c6ec24d2sm15003667pga.89.2022.04.26.23.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 23:26:27 -0700 (PDT)
Date:   Wed, 27 Apr 2022 13:26:25 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Miguel Ojeda <ojeda@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: ppc64_defconfig Werror: no previous prototype on
 arch/powerpc/kernel/ftrace.c
Message-ID: <YmjiEUxHaQ6OQV30@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I did ppc64_defconfig build (gcc 11.2.0) on current master at commit
46cf2c613f4b10 ("Merge tag 'pinctrl-v5.18-2'
of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl"),
and it errored out early like this:

  CC      arch/powerpc/kernel/trace/ftrace.o
arch/powerpc/kernel/trace/ftrace.c:978:7: error: no previous prototype for ‘arch_ftrace_match_adjust’ [-Werror=missing-prototypes]
  978 | char *arch_ftrace_match_adjust(char *str, const char *search)
      |       ^~~~~~~~~~~~~~~~~~~~~~~~
  CC      init/init_task.o
cc1: all warnings being treated as errors
make[3]: *** [scripts/Makefile.build:288: arch/powerpc/kernel/trace/ftrace.o] Error 1
make[2]: *** [scripts/Makefile.build:550: arch/powerpc/kernel/trace] Error 2
make[1]: *** [scripts/Makefile.build:550: arch/powerpc/kernel] Error 2
make: *** [Makefile:1834: arch/powerpc] Error 2

The code in question is introduced by commit 7132e2d669bd42 ("ftrace:
Match dot symbols when searching functions on ppc64").

Reported-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
