Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D92F56551C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbiGDM0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiGDM0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:26:17 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FBAB869;
        Mon,  4 Jul 2022 05:26:16 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id fw3so16435603ejc.10;
        Mon, 04 Jul 2022 05:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MbhbPxsG29azwppMDENZITEFjKUEpPy4AjqCqp4MLu4=;
        b=oeD3/UVr5xQaEcf3Tj8CUpsuiGvAi7oUBD91tzFOE39PRoLJs/9mPWRmEUIjgiNzgX
         A5Onf8H6AzuzybT7bT71sVy264nCnoKP9ZNLspc9NDsmLFfG/UJh7XLi6KignhTB716F
         PUizcCVyReb7RrExl+I+XAd58xCvNB4RktdMOe96vsoxI4YvO5dmdAwg5FL920db77et
         hI6kmea/PHWkZo4VTyXsNHG0V3fDdo6aeSbMuKosAxKSjTVzNzM8flvnKhVXMghZFuHO
         06yvuF63XavIaWV0QZk8dyYct4vkSHS9uWIYchVf0ZAl9xuCpfa7y90epDDpDTA+HWPH
         zwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MbhbPxsG29azwppMDENZITEFjKUEpPy4AjqCqp4MLu4=;
        b=MpXWEPI7iHHlNCASgkWOJAT4AFLWac4J25UhodJ6EJiPIez96w3Epjk7xjV61St9AW
         Jic7Y77Qbevza6N3v6WKH3JpCuDG2LPcRLalgGQ8VqC1VJtZShKFLdgKRZ19+SLvzilL
         QV9/uHivnLI0DebnH4DjdVeRWiWLzABL3FM8w/VNo0hjsqGhUkf42hsNj/2TPPm0zdcG
         UeiaaW74dnYQ9B0e5BIobymBhleGj5D9B1B8/JvPAyD8RyVhrVGbnbNpnS40xpCSnwvK
         8tqBsD4GHfgha+TW/gEaVPDiglMNpBlBx4G4LPlZYr5kOORnoVPOZ32U9fVyht+RFPti
         +GwA==
X-Gm-Message-State: AJIora9iYDc7FNGhVwYk7X35TZDqD1mGFjLNEAEA6DzaafaEN3jpKod7
        z2D0PFQbf3eE1NUhyfNbGVnwIJfQmCw=
X-Google-Smtp-Source: AGRyM1uSCoxC8lVSBMTD0dyWp6+Roen8DDq4kLf2LyJ3Ed39NMyI8C8KkgFTomQ88AgVJ9fa+YY6jw==
X-Received: by 2002:a17:907:3f29:b0:722:e5b0:ebe7 with SMTP id hq41-20020a1709073f2900b00722e5b0ebe7mr27892826ejc.335.1656937575167;
        Mon, 04 Jul 2022 05:26:15 -0700 (PDT)
Received: from felia.fritz.box (200116b826716b008998943ac77556e4.dip.versatel-1u1.de. [2001:16b8:2671:6b00:8998:943a:c775:56e4])
        by smtp.gmail.com with ESMTPSA id k20-20020a1709063fd400b00722f66fb36csm13974467ejj.112.2022.07.04.05.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 05:26:14 -0700 (PDT)
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
Subject: [PATCH 00/11] docs: remove submitting-drivers.rst
Date:   Mon,  4 Jul 2022 14:25:26 +0200
Message-Id: <20220704122537.3407-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
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

Dear Jonathan, dear Federico, dear Alex, dear Yanteng, dear Hu,


Here is an attempt to delete submitting-drivers with some improvements
and clean-up in other documentation places to convince ourselves that
nothing valuable is lost when deleting this checklist.

Patch 1, 2 and 3 is just basic clean-up before adding a new reference (see
Patch 4). Patch 4 adds the one reference from submitting-drivers, not
already mentioned elsewhere in the repository. Patch 5 updates a confusing
statement in devices.rst from earlier .txt/.tex distinction times to the
new state now with Sphinx & .rst.

Patch 6 finally deletes the outdated document, with a cross-check what is
covered elsewhere and few open questions (see below).

Patch 7 and 8 have been reworked with the native-speaking doc maintainers;
they cause no new warnings and are ready to pick,

Patch 9 to 11 are weak attempts to adjust the translation, but they need
to be taken further by others due to my lack of knowledge on the other
languages.  They would currently also cause new warnings in the doc-build
right now. They should not be picked if there is no one to continue
to adjust the text and fix the warnings on broken references.

I hope that patches 1 to 8 can be picked into doc-next, and then we see
how to fix up the translations as well.


Further open considerations:

  - Should we add some subsection/paragraph on Testing to "A guide on
    kernel development process", which then further refers to
    power/drivers-testing.rst for testing the power management of the
    driver?

    (I am bit surprised that code-checking tools are mentioned, but not
    much more on actual kernel testing is mentioned there.)

  - Should we be a bit more explicit on how and when to add a MAINTAINERS
    entry, besides the short note in 6.Followthrough.rst?

  - Translations of submitting-patches.rst and 8.Conclusion.rst in Asian
    languages include a reference to submitting-drivers, I cannot adjust
    the text due to my lack of understanding of the surrounding text.
 
    zh_CN/process/8.Conclusion.rst:和 :ref:`Documentation/translations/zh_CN/process/submitting-drivers.rst <cn_submittingdrivers>`
    zh_CN/process/submitting-patches.rst::ref:`Documentation/process/submitting-drivers.rst <submittingdrivers>`
    zh_TW/process/8.Conclusion.rst:和 :ref:`Documentation/translations/zh_TW/process/submitting-drivers.rst <tw_submittingdrivers>`
    zh_TW/process/submitting-patches.rst::ref:`Documentation/process/submitting-drivers.rst <submittingdrivers>`

    This currently lead to some new warnings in this patch series. I hope
    some native speakers of those languages can help out here. The other
    references were adjusted on a best guess of the text, which should be
    confirmed by native-speaking reviewers.

Generally, I hope we are now all well-convinced to delete submitting-drivers.

Anything else needed to be convinced? I put already some thought into it,
and I am willing to add more content in other documents to properly get rid
of this outdated one here, or just starting writing a good new checklist
for driver submission that reflect what the majority of maintainers want
to see submitters do.

Link to RFC patch series: 
  https://lore.kernel.org/linux-doc/20220627151819.22694-1-lukas.bulwahn@gmail.com/

rfc -> v1: improved Italian and Japanese translation


Best regards,

Lukas


Lukas Bulwahn (11):
  docs: kernel-docs: order reference from newest to oldest
  docs: kernel-docs: shorten the lengthy doc title
  docs: kernel-docs: reflect that it is community-maintained
  docs: kernel-docs: add a reference mentioned in submitting-drivers.rst
  docs: admin: devices:  drop confusing outdated statement on Latex
  docs: process: remove outdated submitting-drivers.rst
  docs: it_IT: align to submitting-drivers removal
  docs: ja_JP: howto: remove reference to removed submitting-drivers
  docs: ko_KR: howto: remove reference to removed submitting-drivers
  docs: zh_CN: align to submitting-drivers removal
  docs: zh_TW: align to submitting-drivers removal

 Documentation/admin-guide/devices.rst         |   7 +-
 Documentation/hwmon/submitting-patches.rst    |   1 -
 Documentation/kernel-hacking/hacking.rst      |   3 +-
 Documentation/process/5.Posting.rst           |   3 +-
 Documentation/process/8.Conclusion.rst        |  16 +-
 Documentation/process/howto.rst               |   4 +-
 Documentation/process/index.rst               |   1 -
 Documentation/process/kernel-docs.rst         |  62 +++---
 Documentation/process/submitting-drivers.rst  | 194 ------------------
 Documentation/process/submitting-patches.rst  |   5 +-
 .../it_IT/kernel-hacking/hacking.rst          |   3 +-
 .../translations/it_IT/process/5.Posting.rst  |   5 +-
 .../it_IT/process/8.Conclusion.rst            |   5 +-
 .../translations/it_IT/process/howto.rst      |   3 +-
 .../translations/it_IT/process/index.rst      |   1 -
 .../it_IT/process/submitting-drivers.rst      |  16 --
 .../it_IT/process/submitting-patches.rst      |   6 +-
 Documentation/translations/ja_JP/howto.rst    |   4 +-
 Documentation/translations/ko_KR/howto.rst    |   2 +-
 .../zh_CN/kernel-hacking/hacking.rst          |   3 +-
 .../translations/zh_CN/process/5.Posting.rst  |   3 +-
 .../translations/zh_CN/process/howto.rst      |   1 -
 .../translations/zh_CN/process/index.rst      |   1 -
 .../zh_CN/process/submitting-drivers.rst      | 160 ---------------
 .../translations/zh_TW/process/5.Posting.rst  |   3 +-
 .../translations/zh_TW/process/howto.rst      |   1 -
 .../translations/zh_TW/process/index.rst      |   1 -
 .../zh_TW/process/submitting-drivers.rst      | 164 ---------------
 28 files changed, 66 insertions(+), 612 deletions(-)
 delete mode 100644 Documentation/process/submitting-drivers.rst
 delete mode 100644 Documentation/translations/it_IT/process/submitting-drivers.rst
 delete mode 100644 Documentation/translations/zh_CN/process/submitting-drivers.rst
 delete mode 100644 Documentation/translations/zh_TW/process/submitting-drivers.rst

-- 
2.17.1

