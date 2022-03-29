Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208674EA698
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 06:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiC2Ebw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 00:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbiC2Ebs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 00:31:48 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75F431DFD;
        Mon, 28 Mar 2022 21:30:04 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id c2so13810006pga.10;
        Mon, 28 Mar 2022 21:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iDv+72tnbPCd3DSLzaLYf0PTI9YrKoCtiTHll5hbSxo=;
        b=jJnV3Ih/oQvR9wHom+3vpmtd3WXbglHQxRDbZr9Q5Tc7KHuzA1EEQhUEe57ncOvz5G
         r4R3qDGTfcXPHn0GCXivRC8r/dM4Y95AkcXP+e87zNJDHF8lFNlkaHEz9xNazptn0ac7
         S+g87nqAQhyIbCqH78tDCUl7ETMEb7ascQZfeSsnbShExQjeZAYpaXhmXC3CuCtZed/2
         hLxew3DWwdqSB3QvsQ2ckrXxDinmONmrAEK4lshzSJV4MxTqQH7jojUmkYZ35VGlsQCc
         MO+PoFHMnqDWL4eQB5p25G4awe1UT32IM/mbASZS2+50LJmtwvJSc6SsO07XhPl3tfIN
         rYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iDv+72tnbPCd3DSLzaLYf0PTI9YrKoCtiTHll5hbSxo=;
        b=XkDKQcYgoOm6117rE1nL7LIDpSuuy03UYKySuLVztaYT8yj+w7Yl8amCpN4Ya/84zk
         eEhdmrug5gcMJ0hE3hCaeJOWfEwPFh7FCdjyWIh96mIFTb/4+4PAlF5b2WQlQUUqcp+b
         S7Kz4xFjPoCjHnqF83fbExzqaqRJKAi6Si49aK9snX4/kUrSeZzpFhNFESaun4H7H6Tw
         KOhn+el5QgXFV2NEcVnuhXJSq5dt18WUbX82M0bvNcIqSi7U+vAwrmstwbfpNkvKAEkT
         wK/mbuc1cSvnIZcWBH1jmJ16KoWbbA9R//O1ZnUPUGddPf67g23b1N6LtYumJBVzfwpW
         ixEA==
X-Gm-Message-State: AOAM530iIhdmXHfIEDGH8+k/RYIXfRc0hrJbuWlHq7HtrLe1Bu7QhkQM
        G6yrMajW0CTWz0f5A/T42e95AEV15G/d7srE
X-Google-Smtp-Source: ABdhPJyvyJiYFgSNnFXkb+GtudDniCtET5BHrKjd/lCTO//44FydLMM3GMybITqswKXMHeU6+3CjpQ==
X-Received: by 2002:a63:4421:0:b0:385:d870:d598 with SMTP id r33-20020a634421000000b00385d870d598mr604204pga.361.1648528203991;
        Mon, 28 Mar 2022 21:30:03 -0700 (PDT)
Received: from ubuntu.mate (subs32-116-206-28-55.three.co.id. [116.206.28.55])
        by smtp.gmail.com with ESMTPSA id z13-20020a17090a468d00b001c7db8e6ac7sm1055075pjf.40.2022.03.28.21.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 21:30:03 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Documentation: siphash: convert danger note to warning for HalfSipHash
Date:   Tue, 29 Mar 2022 11:29:51 +0700
Message-Id: <20220329042952.10100-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220329042952.10100-1-bagasdotme@gmail.com>
References: <20220329042952.10100-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Render danger paragraph into warning block for emphasization.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Eric Biggers <ebiggers@google.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/security/siphash.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/security/siphash.rst b/Documentation/security/siphash.rst
index bd9363025fcbc1..42794a7e052f1e 100644
--- a/Documentation/security/siphash.rst
+++ b/Documentation/security/siphash.rst
@@ -121,12 +121,12 @@ even scarier, uses an easily brute-forcable 64-bit key (with a 32-bit output)
 instead of SipHash's 128-bit key. However, this may appeal to some
 high-performance `jhash` users.
 
-Danger!
-
-Do not ever use HalfSipHash except for as a hashtable key function, and only
-then when you can be absolutely certain that the outputs will never be
-transmitted out of the kernel. This is only remotely useful over `jhash` as a
-means of mitigating hashtable flooding denial of service attacks.
+.. warning::
+   Do not ever use HalfSipHash except for as a hashtable key function, and
+   only then when you can be absolutely certain that the outputs will never
+   be transmitted out of the kernel. This is only remotely useful over
+   `jhash` as a means of mitigating hashtable flooding denial of service
+   attacks.
 
 Generating a HalfSipHash key
 ============================
-- 
An old man doll... just what I always wanted! - Clara

