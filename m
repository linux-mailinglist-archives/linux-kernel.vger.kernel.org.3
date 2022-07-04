Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689CE565536
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbiGDM1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbiGDM0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:26:46 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4A2DF8C;
        Mon,  4 Jul 2022 05:26:31 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id d2so16512505ejy.1;
        Mon, 04 Jul 2022 05:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NayUPzpYo0U0IPkA4YIt21GbM97EcjfkD5WbDbC9ho0=;
        b=Xps446Q8BscxKyTOKJM+98ugCX3kPmNleKq+7O8vXRtAF0kl2P+OjmVPFiMzm9xOwR
         c2/Q75VWHDvtejhSDXljwsNCy3YnX5I17vhhALgj8MrugJYyzCt0N1V3N/9p8PF37IE4
         AS95jereum1xsV79jPZDRxHAcq54eo5CkWHO3EqSQiPo63TFYZNx3rRcNC228Y5b+WGT
         TVZ/de8pS80VRR3TrPOA5ETlwfwfE77ziV5aTwcJbq2K1opb66PpiuxzY/pjQYeCjqrp
         TksxUV9e6fk2cY7ChbUUIaJPZK0eAONhqQxffn++VVZ+XH4vG/pvtCN2dx4PAuZL+wbX
         6xUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NayUPzpYo0U0IPkA4YIt21GbM97EcjfkD5WbDbC9ho0=;
        b=QBe15d3AZ5TUT1pzFcNCi8FTF3U2AHcSdnATwDyBbwnaCONhBO7/kJA/wL4Qf6mHFI
         21fCTqnzLdmFKe0KfN1E3LGsHoWCpUllK4ItJTaMKFe9eOcOUGtPnF6g6gEfK5BKUB5w
         XEFBRlyDL+yITfwS2SIHMkY9gRol03Bp2JikbDjjx3qeywiqHXlIZdz6rb2QobisBlKD
         olQaaNnTE90Xab2D84v7JRvBc1nz9YKjZg8fRElv6chl/pmcXKJdGJ/v83YNuXKmIx6v
         VS/x4/cLmQEdDrRlvr8mHrXb12XrS7Agud5ufa4+CX7hKsyf1dw85wZ+ZzxyLDc/rtly
         LTyg==
X-Gm-Message-State: AJIora+6ZXLxQzhH/CxPSUCT3j9Nan0Ra3nNdumIyGb8oYRGLU9FTf7d
        LBKJ5RY3NN/x6td+gOjfeRY=
X-Google-Smtp-Source: AGRyM1t2dP6RX1m9fei1stdiNefvDOY1J5rfhOhP+2lxdCacqtDpKSIpuTbw2kX3zladm1Vj90SO/A==
X-Received: by 2002:a17:906:d7:b0:718:df95:985 with SMTP id 23-20020a17090600d700b00718df950985mr28515984eji.582.1656937589598;
        Mon, 04 Jul 2022 05:26:29 -0700 (PDT)
Received: from felia.fritz.box (200116b826716b008998943ac77556e4.dip.versatel-1u1.de. [2001:16b8:2671:6b00:8998:943a:c775:56e4])
        by smtp.gmail.com with ESMTPSA id k20-20020a1709063fd400b00722f66fb36csm13974467ejj.112.2022.07.04.05.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 05:26:29 -0700 (PDT)
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
Subject: [PATCH 07/11] docs: it_IT: align to submitting-drivers removal
Date:   Mon,  4 Jul 2022 14:25:33 +0200
Message-Id: <20220704122537.3407-8-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220704122537.3407-1-lukas.bulwahn@gmail.com>
References: <20220704122537.3407-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Adjust the Italian translation to the removal of submitting-drivers in the
English kernel documentation, with some assistance from Frederico Vaga.

Link: https://lore.kernel.org/linux-doc/20220628091647.xf5cygybqemwprgb@numero86.vaga.pv.it/

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 .../it_IT/kernel-hacking/hacking.rst             |  3 +--
 .../translations/it_IT/process/5.Posting.rst     |  5 ++---
 .../translations/it_IT/process/8.Conclusion.rst  |  5 ++---
 .../translations/it_IT/process/howto.rst         |  3 +--
 .../translations/it_IT/process/index.rst         |  1 -
 .../it_IT/process/submitting-drivers.rst         | 16 ----------------
 .../it_IT/process/submitting-patches.rst         |  6 ++----
 7 files changed, 8 insertions(+), 31 deletions(-)
 delete mode 100644 Documentation/translations/it_IT/process/submitting-drivers.rst

diff --git a/Documentation/translations/it_IT/kernel-hacking/hacking.rst b/Documentation/translations/it_IT/kernel-hacking/hacking.rst
index d5c521327f6a..4bec4669cf48 100644
--- a/Documentation/translations/it_IT/kernel-hacking/hacking.rst
+++ b/Documentation/translations/it_IT/kernel-hacking/hacking.rst
@@ -795,8 +795,7 @@ anche per avere patch pulite, c'è del lavoro amministrativo da fare:
    di un semplice impegno su una parte del codice.
 
 -  Infine, non dimenticatevi di leggere
-   ``Documentation/process/submitting-patches.rst`` e possibilmente anche
-   ``Documentation/process/submitting-drivers.rst``.
+   ``Documentation/process/submitting-patches.rst``.
 
 Trucchetti del kernel
 =====================
diff --git a/Documentation/translations/it_IT/process/5.Posting.rst b/Documentation/translations/it_IT/process/5.Posting.rst
index 1476d51eb5e5..a036f38fc82e 100644
--- a/Documentation/translations/it_IT/process/5.Posting.rst
+++ b/Documentation/translations/it_IT/process/5.Posting.rst
@@ -16,9 +16,8 @@ e di procedure per la pubblicazione delle patch; seguirle renderà la vita
 più facile a tutti quanti.  Questo documento cercherà di coprire questi
 argomenti con un ragionevole livello di dettaglio; più informazioni possono
 essere trovare nella cartella 'Documentation', nei file
-:ref:`translations/it_IT/process/submitting-patches.rst <it_submittingpatches>`,
-:ref:`translations/it_IT/process/submitting-drivers.rst <it_submittingdrivers>`, e
-:ref:`translations/it_IT/process/submit-checklist.rst <it_submitchecklist>`.
+:ref:`translations/it_IT/process/submitting-patches.rst <it_submittingpatches>`
+e :ref:`translations/it_IT/process/submit-checklist.rst <it_submitchecklist>`.
 
 
 Quando pubblicarle
diff --git a/Documentation/translations/it_IT/process/8.Conclusion.rst b/Documentation/translations/it_IT/process/8.Conclusion.rst
index 039bfc5a4108..32659ff467c0 100644
--- a/Documentation/translations/it_IT/process/8.Conclusion.rst
+++ b/Documentation/translations/it_IT/process/8.Conclusion.rst
@@ -13,9 +13,8 @@ e argomenti correlati. Primo tra questi sarà sempre la cartella Documentation
 che si trova nei sorgenti kernel.
 
 Il file :ref:`process/howto.rst <it_process_howto>` è un punto di partenza
-importante; :ref:`process/submitting-patches.rst <it_submittingpatches>` e
-:ref:`process/submitting-drivers.rst <it_submittingdrivers>` sono
-anch'essi qualcosa che tutti gli sviluppatori del kernel dovrebbero leggere.
+importante; :ref:`process/submitting-patches.rst <it_submittingpatches>` è
+anch'esso qualcosa che tutti gli sviluppatori del kernel dovrebbero leggere.
 Molte API interne al kernel sono documentate utilizzando il meccanismo
 kerneldoc; "make htmldocs" o "make pdfdocs" possono essere usati per generare
 quei documenti in HTML o PDF (sebbene le versioni di TeX di alcune
diff --git a/Documentation/translations/it_IT/process/howto.rst b/Documentation/translations/it_IT/process/howto.rst
index 9554368a2ae2..16ad5622d549 100644
--- a/Documentation/translations/it_IT/process/howto.rst
+++ b/Documentation/translations/it_IT/process/howto.rst
@@ -109,8 +109,7 @@ Di seguito una lista di file che sono presenti nei sorgente del kernel e che
     accetteranno patch solo se queste osserveranno tali regole, e molte
     persone revisioneranno il codice solo se scritto nello stile appropriato.
 
-  :ref:`Documentation/translations/it_IT/process/submitting-patches.rst <it_submittingpatches>` e
-  :ref:`Documentation/translations/it_IT/process/submitting-drivers.rst <it_submittingdrivers>`
+  :ref:`Documentation/translations/it_IT/process/submitting-patches.rst <it_submittingpatches>`
 
     Questo file descrive dettagliatamente come creare ed inviare una patch
     con successo, includendo (ma non solo questo):
diff --git a/Documentation/translations/it_IT/process/index.rst b/Documentation/translations/it_IT/process/index.rst
index c4c867132c88..b223b70a4a95 100644
--- a/Documentation/translations/it_IT/process/index.rst
+++ b/Documentation/translations/it_IT/process/index.rst
@@ -41,7 +41,6 @@ degli sviluppatori:
    :maxdepth: 1
 
    changes
-   submitting-drivers
    stable-api-nonsense
    management-style
    stable-kernel-rules
diff --git a/Documentation/translations/it_IT/process/submitting-drivers.rst b/Documentation/translations/it_IT/process/submitting-drivers.rst
deleted file mode 100644
index dadd77e47613..000000000000
--- a/Documentation/translations/it_IT/process/submitting-drivers.rst
+++ /dev/null
@@ -1,16 +0,0 @@
-.. include:: ../disclaimer-ita.rst
-
-:Original: :ref:`Documentation/process/submitting-drivers.rst <submittingdrivers>`
-:Translator: Federico Vaga <federico.vaga@vaga.pv.it>
-
-.. _it_submittingdrivers:
-
-Sottomettere driver per il kernel Linux
-=======================================
-
-.. note::
-
-   Questo documento è vecchio e negli ultimi anni non è stato più aggiornato;
-   dovrebbe essere aggiornato, o forse meglio, rimosso.  La maggior parte di
-   quello che viene detto qui può essere trovato anche negli altri documenti
-   dedicati allo sviluppo.  Per questo motivo il documento non verrà tradotto.
diff --git a/Documentation/translations/it_IT/process/submitting-patches.rst b/Documentation/translations/it_IT/process/submitting-patches.rst
index 4fb5b3aa306d..f117ee0a36e2 100644
--- a/Documentation/translations/it_IT/process/submitting-patches.rst
+++ b/Documentation/translations/it_IT/process/submitting-patches.rst
@@ -18,10 +18,8 @@ Questo documento contiene un vasto numero di suggerimenti concisi. Per maggiori
 dettagli su come funziona il processo di sviluppo del kernel leggete
 Documentation/translations/it_IT/process/development-process.rst. Leggete anche
 Documentation/translations/it_IT/process/submit-checklist.rst per una lista di
-punti da verificare prima di inviare del codice. Se state inviando un driver,
-allora leggete anche
-Documentation/translations/it_IT/process/submitting-drivers.rst; per delle patch
-relative alle associazioni per Device Tree leggete
+punti da verificare prima di inviare del codice.
+Per delle patch relative alle associazioni per Device Tree leggete
 Documentation/translations/it_IT/process/submitting-patches.rst.
 
 Questa documentazione assume che sappiate usare ``git`` per preparare le patch.
-- 
2.17.1

