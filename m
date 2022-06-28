Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8A855DE20
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344179AbiF1J0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiF1J0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:26:16 -0400
X-Greylist: delayed 551 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Jun 2022 02:26:12 PDT
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB064F1C;
        Tue, 28 Jun 2022 02:26:12 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mx.kolabnow.com (Postfix) with ESMTP id 234401578;
        Tue, 28 Jun 2022 11:16:58 +0200 (CEST)
Authentication-Results: ext-mx-out001.mykolab.com (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        in-reply-to:content-transfer-encoding:content-disposition
        :content-type:content-type:mime-version:references:message-id
        :subject:subject:from:from:date:date:received:received:received;
         s=dkim20160331; t=1656407817; x=1658222218; bh=RIkRffI1aOt9aTQA
        qThSaSDKmYghWKPv5goHGRh30Mw=; b=sXswAtnrY7wi579FJ2ayqkwU0/9WjKSX
        2STY25wdeFJ9Hofx3++gzDNbV6Wi9EbLKp5dQp0g+K78F7kVwKr3gk6QgDvcJD1X
        aBL9beDLypQRqQoXbcVC03mJQ749qcHPt8S6BDVglsN/9EX+jYs3s0ZR+Os484VC
        QjRYY6D9BdDOc59XxbY+88gmylbHmL7sbtBEgZbJnEcifeZyhP/xOwN78N9l13iU
        D/bprQPWIruuPjIm2HmHvxRdEfWhLS/wF2ImZ0+uX6KjiaDkX1rYhbTOq2nECCG9
        X/5RoAD+Aour8Q2MW724UbKlzcaqk16Bn0JLbJwb/+ON3n0KvGyrGWSFFLDz91nA
        q2KIC8mTvysUylyeSTfpa1Ben//PtdEz+ag7LFf5/CPICQ6tQ/87C6WdoB1JdI4e
        hpE9czf5iBwkXsWUsxHYLYO9RKXajlrOy+L2Wbwz9MkjuCRK8aiFZz2Bz7rOPyQX
        FAy1S4DKD/8jPtNRkxpyeeJ+4wnQOP8fLuF+jQHYiCDIUqXznMfcUVc/vKF416fV
        mW7rG4ZGLtFs4GxSWU0pX8DvtvJ4hulvwiFwstCNL+vmx7QJCYzEgg+aT9QVO6Q4
        xno+sp2112kRUC33YzrDwNblrbBEyyHEatWa0F0S0QR/WfQLDaIFKL88zVkbF5jU
        vwP8PQfwG5o=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WJ3Rig7sth7S; Tue, 28 Jun 2022 11:16:57 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by mx.kolabnow.com (Postfix) with ESMTPS id CA5921575;
        Tue, 28 Jun 2022 11:16:55 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 2477D2E4E;
        Tue, 28 Jun 2022 11:16:52 +0200 (CEST)
Date:   Tue, 28 Jun 2022 11:16:47 +0200
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>, linux-doc@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 07/11] docs: it_IT: align to submitting-drivers
 removal
Message-ID: <20220628091647.xf5cygybqemwprgb@numero86.vaga.pv.it>
References: <20220627151819.22694-1-lukas.bulwahn@gmail.com>
 <20220627151819.22694-8-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220627151819.22694-8-lukas.bulwahn@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 05:18:15PM +0200, Lukas Bulwahn wrote:
>Adjust the Italian translation to the removal of submitting-drivers in the
>English kernel documentation.
>
>Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
>---
> .../it_IT/kernel-hacking/hacking.rst             |  3 +--
> .../translations/it_IT/process/5.Posting.rst     |  5 ++---
> .../translations/it_IT/process/8.Conclusion.rst  |  3 +--
> .../translations/it_IT/process/howto.rst         |  3 +--
> .../translations/it_IT/process/index.rst         |  1 -
> .../it_IT/process/submitting-drivers.rst         | 16 ----------------
> .../it_IT/process/submitting-patches.rst         |  6 ++----
> 7 files changed, 7 insertions(+), 30 deletions(-)
> delete mode 100644 Documentation/translations/it_IT/process/submitting-drivers.rst
>
>diff --git a/Documentation/translations/it_IT/kernel-hacking/hacking.rst b/Documentation/translations/it_IT/kernel-hacking/hacking.rst
>index d5c521327f6a..4bec4669cf48 100644
>--- a/Documentation/translations/it_IT/kernel-hacking/hacking.rst
>+++ b/Documentation/translations/it_IT/kernel-hacking/hacking.rst
>@@ -795,8 +795,7 @@ anche per avere patch pulite, c'è del lavoro amministrativo da fare:
>    di un semplice impegno su una parte del codice.
>
> -  Infine, non dimenticatevi di leggere
>-   ``Documentation/process/submitting-patches.rst`` e possibilmente anche
>-   ``Documentation/process/submitting-drivers.rst``.
>+   ``Documentation/process/submitting-patches.rst``.
>
> Trucchetti del kernel
> =====================
>diff --git a/Documentation/translations/it_IT/process/5.Posting.rst b/Documentation/translations/it_IT/process/5.Posting.rst
>index 1476d51eb5e5..a036f38fc82e 100644
>--- a/Documentation/translations/it_IT/process/5.Posting.rst
>+++ b/Documentation/translations/it_IT/process/5.Posting.rst
>@@ -16,9 +16,8 @@ e di procedure per la pubblicazione delle patch; seguirle renderà la vita
> più facile a tutti quanti.  Questo documento cercherà di coprire questi
> argomenti con un ragionevole livello di dettaglio; più informazioni possono
> essere trovare nella cartella 'Documentation', nei file
>-:ref:`translations/it_IT/process/submitting-patches.rst <it_submittingpatches>`,
>-:ref:`translations/it_IT/process/submitting-drivers.rst <it_submittingdrivers>`, e
>-:ref:`translations/it_IT/process/submit-checklist.rst <it_submitchecklist>`.
>+:ref:`translations/it_IT/process/submitting-patches.rst <it_submittingpatches>`
>+e :ref:`translations/it_IT/process/submit-checklist.rst <it_submitchecklist>`.

Fixing plural. The final correct statement must be:

nel file :ref:`translations/it_IT/process/submitting-patches.rst <it_submittingpatches>`.

Notice 'nei file' -> 'nel file'


>
>
> Quando pubblicarle
>diff --git a/Documentation/translations/it_IT/process/8.Conclusion.rst b/Documentation/translations/it_IT/process/8.Conclusion.rst
>index 039bfc5a4108..efaad6c7702c 100644
>--- a/Documentation/translations/it_IT/process/8.Conclusion.rst
>+++ b/Documentation/translations/it_IT/process/8.Conclusion.rst
>@@ -13,8 +13,7 @@ e argomenti correlati. Primo tra questi sarà sempre la cartella Documentation
> che si trova nei sorgenti kernel.
>
> Il file :ref:`process/howto.rst <it_process_howto>` è un punto di partenza
>-importante; :ref:`process/submitting-patches.rst <it_submittingpatches>` e
>-:ref:`process/submitting-drivers.rst <it_submittingdrivers>` sono
>+importante; :ref:`process/submitting-patches.rst <it_submittingpatches>` sono
> anch'essi qualcosa che tutti gli sviluppatori del kernel dovrebbero leggere.

Fixing plural. the final correct statement must be:

:ref:`process/submitting-patches.rst <it_submittingpatches>` è anch'esso
qualcosa che tutti gli sviluppatori del kernel dovrebbero leggere.

Notice "sono anch'essi" -> "è anch'esso"


> Molte API interne al kernel sono documentate utilizzando il meccanismo
> kerneldoc; "make htmldocs" o "make pdfdocs" possono essere usati per generare
>diff --git a/Documentation/translations/it_IT/process/howto.rst b/Documentation/translations/it_IT/process/howto.rst
>index 9554368a2ae2..16ad5622d549 100644
>--- a/Documentation/translations/it_IT/process/howto.rst
>+++ b/Documentation/translations/it_IT/process/howto.rst
>@@ -109,8 +109,7 @@ Di seguito una lista di file che sono presenti nei sorgente del kernel e che
>     accetteranno patch solo se queste osserveranno tali regole, e molte
>     persone revisioneranno il codice solo se scritto nello stile appropriato.
>
>-  :ref:`Documentation/translations/it_IT/process/submitting-patches.rst <it_submittingpatches>` e
>-  :ref:`Documentation/translations/it_IT/process/submitting-drivers.rst <it_submittingdrivers>`
>+  :ref:`Documentation/translations/it_IT/process/submitting-patches.rst <it_submittingpatches>`
>
>     Questo file descrive dettagliatamente come creare ed inviare una patch
>     con successo, includendo (ma non solo questo):
>diff --git a/Documentation/translations/it_IT/process/index.rst b/Documentation/translations/it_IT/process/index.rst
>index c4c867132c88..b223b70a4a95 100644
>--- a/Documentation/translations/it_IT/process/index.rst
>+++ b/Documentation/translations/it_IT/process/index.rst
>@@ -41,7 +41,6 @@ degli sviluppatori:
>    :maxdepth: 1
>
>    changes
>-   submitting-drivers
>    stable-api-nonsense
>    management-style
>    stable-kernel-rules
>diff --git a/Documentation/translations/it_IT/process/submitting-drivers.rst b/Documentation/translations/it_IT/process/submitting-drivers.rst
>deleted file mode 100644
>index dadd77e47613..000000000000
>--- a/Documentation/translations/it_IT/process/submitting-drivers.rst
>+++ /dev/null
>@@ -1,16 +0,0 @@
>-.. include:: ../disclaimer-ita.rst
>-
>-:Original: :ref:`Documentation/process/submitting-drivers.rst <submittingdrivers>`
>-:Translator: Federico Vaga <federico.vaga@vaga.pv.it>
>-
>-.. _it_submittingdrivers:
>-
>-Sottomettere driver per il kernel Linux
>-=======================================
>-
>-.. note::
>-
>-   Questo documento è vecchio e negli ultimi anni non è stato più aggiornato;
>-   dovrebbe essere aggiornato, o forse meglio, rimosso.  La maggior parte di
>-   quello che viene detto qui può essere trovato anche negli altri documenti
>-   dedicati allo sviluppo.  Per questo motivo il documento non verrà tradotto.
>diff --git a/Documentation/translations/it_IT/process/submitting-patches.rst b/Documentation/translations/it_IT/process/submitting-patches.rst
>index 4fb5b3aa306d..f117ee0a36e2 100644
>--- a/Documentation/translations/it_IT/process/submitting-patches.rst
>+++ b/Documentation/translations/it_IT/process/submitting-patches.rst
>@@ -18,10 +18,8 @@ Questo documento contiene un vasto numero di suggerimenti concisi. Per maggiori
> dettagli su come funziona il processo di sviluppo del kernel leggete
> Documentation/translations/it_IT/process/development-process.rst. Leggete anche
> Documentation/translations/it_IT/process/submit-checklist.rst per una lista di
>-punti da verificare prima di inviare del codice. Se state inviando un driver,
>-allora leggete anche
>-Documentation/translations/it_IT/process/submitting-drivers.rst; per delle patch
>-relative alle associazioni per Device Tree leggete
>+punti da verificare prima di inviare del codice.
>+Per delle patch relative alle associazioni per Device Tree leggete
> Documentation/translations/it_IT/process/submitting-patches.rst.

I see here what you mentioned in the cover. Yes the path should point elsewhere.
I will send a patch for it.

> Questa documentazione assume che sappiate usare ``git`` per preparare le patch.
>-- 
>2.17.1
>

-- 
~ - ~ - ~ - ~
Federico Vaga
