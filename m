Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5814955C309
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238115AbiF0PVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 11:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237913AbiF0PTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:19:35 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5336C186D5;
        Mon, 27 Jun 2022 08:19:31 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id sb34so19827480ejc.11;
        Mon, 27 Jun 2022 08:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A57xIfZLi+2djoYykZ8gRv7aiC4YCwj7z7nIR/tXI5o=;
        b=EGz/XpsKKLfmjtdBn1Lm3Hdi5YjzU9PXS3dJqHwt6Lifhd9eJagsVKS/kR/Zbc8ypb
         s+VN3uQ3Q6bLZ/TKn9lU3ITuxgiQjlV4TNYGcZ5CjLJXekx7z2o6kwv7iiSW0KZBXJzf
         BN/i3twdfPFAsO8WmU7bNFse42ImEC0ADJYNAfOjCgqblQ94H/2LvHMz+R8xrqK8SLap
         Jo29NHi3Og3XRVCCk2potfdEL0cYoqufA44TA1aA1mRk0P7pJvhsL5czQgS04VBTVBG8
         soauAboqoPMAWLSuPumbX6y6JVOX3QmewRlZDIYEAiPDiCMcw7GsUiFQYeqKQcFZolX+
         T4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A57xIfZLi+2djoYykZ8gRv7aiC4YCwj7z7nIR/tXI5o=;
        b=z3NCz3pcXCnFxsoQxfmwFp0dvUro3xtdsqkFcVgu5EkC+YsgUHN0kFVy575RZtb1VA
         9IB9ZlyKSIKk7DltVjU52wYcNJJlLiDZj6FCnnYEopJOaqMevsfpaWxjKvEF5IaE2Cvo
         i9ydOBTyY7UAPxRYnS/uCCj5LcjXP+ZbbTp75Qbc5EXHXonQz7g9FS2+09CZ8SlquxZb
         PnBS7NSYz2OTgwYa5KIE5u1SztjebFhQLD2c6epdnJS2WQ/NSb3riBBkT6ewkhnLPvnU
         rLUS5LieTsq6tkAOuGYAZ59egNngkiJBtYVA8hu1CMPphjRfXGmoE/G9MgMrn6SVeAwN
         Tq1Q==
X-Gm-Message-State: AJIora9zQIK6m3JA+yKN51xVawIymluygbCyhG5/TzsH5Jqp+HWJmIbv
        ByBa28W8/iSe8uonBKSs1JIAGQc805c=
X-Google-Smtp-Source: AGRyM1tOeRMGn+YzZTdvoyChBz/sbhqaW0+PYBXWz3S98szKG9T/O0zWiEn5zkmVpHUWODkZRq6lkQ==
X-Received: by 2002:a17:906:794f:b0:722:e857:1a8f with SMTP id l15-20020a170906794f00b00722e8571a8fmr13153480ejo.494.1656343170916;
        Mon, 27 Jun 2022 08:19:30 -0700 (PDT)
Received: from felia.fritz.box (200116b826511b0021a0c74157938809.dip.versatel-1u1.de. [2001:16b8:2651:1b00:21a0:c741:5793:8809])
        by smtp.gmail.com with ESMTPSA id z8-20020a170906434800b00722f2a0944fsm5076901ejm.107.2022.06.27.08.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 08:19:30 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>, linux-doc@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [RFC PATCH 09/11] docs: ko_KR: howto: remove reference to removed submitting-drivers
Date:   Mon, 27 Jun 2022 17:18:17 +0200
Message-Id: <20220627151819.22694-10-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220627151819.22694-1-lukas.bulwahn@gmail.com>
References: <20220627151819.22694-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The document submitting-drivers.rst was deleted. This removes the
corresponding reference in the Korean translation of the howto.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 Documentation/translations/ko_KR/howto.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/ko_KR/howto.rst b/Documentation/translations/ko_KR/howto.rst
index e3cdf0c84892..e43970584ca4 100644
--- a/Documentation/translations/ko_KR/howto.rst
+++ b/Documentation/translations/ko_KR/howto.rst
@@ -124,7 +124,7 @@ mtk.manpages@gmail.com의 메인테이너에게 보낼 것을 권장한다.
     메인테이너들은 이 규칙을 따르는 패치들만을 받아들일 것이고 많은 사람들이
     그 패치가 올바른 스타일일 경우만 코드를 검토할 것이다.
 
-  :ref:`Documentation/process/submitting-patches.rst <submittingpatches>` 와 :ref:`Documentation/process/submitting-drivers.rst <submittingdrivers>`
+  :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
     이 파일들은 성공적으로 패치를 만들고 보내는 법을 다음의 내용들로
     굉장히 상세히 설명하고 있다(그러나 다음으로 한정되진 않는다).
 
-- 
2.17.1

