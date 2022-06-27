Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3322755E2DB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238103AbiF0PUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 11:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237002AbiF0PT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:19:29 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECDD186C4;
        Mon, 27 Jun 2022 08:19:28 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ge10so19879784ejb.7;
        Mon, 27 Jun 2022 08:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gk9NqUP5VmgLSPwX1E4bueQH1EvvH5QIeniiIcfK5oE=;
        b=KDw98tpqFci1ayA6kE1kvoDvey23oxfOW0glEiGNOnqlCpGfNUzH2Sc3/0dWdUS42J
         0Lg5OCpNrwN+cKuCtzbDJmVgqkb0zID1Tro/pQy24QpzOoysaK0baPKy1mq9FnHaJQCx
         HyAFsDev2/JsbnsKMEFmF5KmBUq/IrTDMuC/jxugtSdW4CyC5Ug+Gz3fVlQr/8DRJ8nv
         LC5yMwO8dI8myfPFfVsDOLWnTscOIEx03SEG6kmrtca9pBNv3q4h/Hf3Fpav334a5iME
         aXg79gPUTgejIBSG5iur/ZcTovRTdAXoDeV0C7zBS8AgCHv9HESF0j+i4Hn7qp5GgJ4m
         9jDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gk9NqUP5VmgLSPwX1E4bueQH1EvvH5QIeniiIcfK5oE=;
        b=BN2ZnsLGqPxORccSVZN6hebd44iCcC3y2X0I5o3qe20O0AD335yFzjixkxGrPPq19o
         srACo5VMA0F2mxNqpL8gZheVhPKbXrlxTMjryUezHPckSa/8xqKc9kiSVZw6thcu1wuP
         AY4DJx5sVTfSrc5Y+4nZ82et2SlBIBYLyZ4k/22jf0pOB0NJLitvlf2SVnz0Vd3tTGCz
         H/CAPe86VMa7havNprcMLHUOyZBZhtDEk78Km3EpNQkh/GQEN5Px/5XQsaV4nthmFskD
         gm5w+JOQrirdmR9zCyXNK8wWZ+ZdZMvsA/sltITCbtv250WVvUHgkeMlQZW1Sn4u/ySI
         1XaA==
X-Gm-Message-State: AJIora9l58jJjSI1+nuVx+I5sHmHod30e0o6VJ8uGf7t/A7DPzqmdOIz
        OUyS04sihCJDpRp0NFzA0pc=
X-Google-Smtp-Source: AGRyM1s4iUevBb42EgTTT2hnOhLT6DC34fPW/rj/jHrCXsvvT/HRMb5Fkc3ZnyHKkF4iUdUZX9dtzA==
X-Received: by 2002:a17:906:51db:b0:722:ea9b:ff9e with SMTP id v27-20020a17090651db00b00722ea9bff9emr13527752ejk.16.1656343166828;
        Mon, 27 Jun 2022 08:19:26 -0700 (PDT)
Received: from felia.fritz.box (200116b826511b0021a0c74157938809.dip.versatel-1u1.de. [2001:16b8:2651:1b00:21a0:c741:5793:8809])
        by smtp.gmail.com with ESMTPSA id z8-20020a170906434800b00722f2a0944fsm5076901ejm.107.2022.06.27.08.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 08:19:26 -0700 (PDT)
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
Subject: [RFC PATCH 07/11] docs: it_IT: align to submitting-drivers removal
Date:   Mon, 27 Jun 2022 17:18:15 +0200
Message-Id: <20220627151819.22694-8-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220627151819.22694-1-lukas.bulwahn@gmail.com>
References: <20220627151819.22694-1-lukas.bulwahn@gmail.com>
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
English kernel documentation.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 .../it_IT/kernel-hacking/hacking.rst             |  3 +--
 .../translations/it_IT/process/5.Posting.rst     |  5 ++---
 .../translations/it_IT/process/8.Conclusion.rst  |  3 +--
 .../translations/it_IT/process/howto.rst         |  3 +--
 .../translations/it_IT/process/index.rst         |  1 -
 .../it_IT/process/submitting-drivers.rst         | 16 ----------------
 .../it_IT/process/submitting-patches.rst         |  6 ++----
 7 files changed, 7 insertions(+), 30 deletions(-)
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
index 039bfc5a4108..efaad6c7702c 100644
--- a/Documentation/translations/it_IT/process/8.Conclusion.rst
+++ b/Documentation/translations/it_IT/process/8.Conclusion.rst
@@ -13,8 +13,7 @@ e argomenti correlati. Primo tra questi sarà sempre la cartella Documentation
 che si trova nei sorgenti kernel.
 
 Il file :ref:`process/howto.rst <it_process_howto>` è un punto di partenza
-importante; :ref:`process/submitting-patches.rst <it_submittingpatches>` e
-:ref:`process/submitting-drivers.rst <it_submittingdrivers>` sono
+importante; :ref:`process/submitting-patches.rst <it_submittingpatches>` sono
 anch'essi qualcosa che tutti gli sviluppatori del kernel dovrebbero leggere.
 Molte API interne al kernel sono documentate utilizzando il meccanismo
 kerneldoc; "make htmldocs" o "make pdfdocs" possono essere usati per generare
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

