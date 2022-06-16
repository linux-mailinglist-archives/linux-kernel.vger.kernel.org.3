Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71BB54ECD9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 23:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377511AbiFPVul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 17:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbiFPVuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 17:50:39 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB975D5EB
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 14:50:38 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id p6-20020a05600c1d8600b0039c630b8d96so3762223wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 14:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=63EZGc+o0cM+qvMs6EvyjK8Q4wCuaZT9KczPfbcd01w=;
        b=c9vfKyAXUULzy2epzgsotVRhp4usgeuVFpkd7lXUc7yuV/Yh4QY6duYGm8/gA9OkeP
         c3MBNRcJ6nWgDlg/cPMiyv2LWlpW2KeKnBbs1Q+PpwBHfAQGu+sSvegHST26DbW9H8E+
         wTVvrI5HWTJOM5Ayv8htLilh4mnJct9ke1DpPeauw8jwBpHm8v6bG7r3qmTv52moDtER
         aPrBaxoCrXewTsSqyC1mnLN5YuZ18XlrXIO9TsoifnNrJmO5AcaJ6VsMzWB9b4fWpq+p
         qn8k96S/xv68Oa2XRCQqHXZnvXW940L/AGUNkxmT9e0AI7Qjjj1fBDKaw80WJecPIC9z
         hOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=63EZGc+o0cM+qvMs6EvyjK8Q4wCuaZT9KczPfbcd01w=;
        b=gqWeQMSdJPIFGQzxV4mDzh6Fr19Zckqzt5neksJJTzitN9VzWJWcS9lSanvnwTivQl
         W/WvHwfVhpl26Y8+uTNGqxrcGGsUxKrCLKfqMmIXt/sat5MXe8YxuY0VR8BumAx8qxme
         gc0Zo9yOMiiWaWLPh6lFJDkyEK8FAbHKyRqGirlnbwcQcU9GSNietN602c2PvLd9hGu0
         REFDv/0FJa1VhKrv+RkQimjr1XkoDNB+UwcLmigFxeMLq2Aqwp/G/aeU0Re0mxvfV+aX
         +FE0MOA/IcGdWBwC2Vr/FPRqeyaKl3Anq43aYfW7lKyqt7g/hWO7Y6I6MarSFbVqwxcW
         V3xw==
X-Gm-Message-State: AJIora/bCQkFwcjm9rxuKFDz8BJywp2P/ywidvkKNj+2NbDA9HpU0MS7
        FFhrjinlPf0lfeqn5y3sMtqzu2yxv3WfEyvZjWFwW08/n+dl
X-Google-Smtp-Source: AGRyM1u6p/2YGmOttcRdu2VI54P46DNaFqcmfDr4TsKqcGHmpLCvO3lJpEjbbi0PxTqZgsxDFNm8kjAVOP+MRqnPm+8=
X-Received: by 2002:a7b:c38b:0:b0:39c:6964:34a2 with SMTP id
 s11-20020a7bc38b000000b0039c696434a2mr6905407wmj.165.1655416237107; Thu, 16
 Jun 2022 14:50:37 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 16 Jun 2022 17:50:26 -0400
Message-ID: <CAHC9VhSjdCsyVz+Y7Xttvr2X389aDYiCvJYR-DEGa53AvmHs-w@mail.gmail.com>
Subject: [GIT PULL] Audit fixes for v5.19 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

A single audit patch to fix a problem where we were not properly
freeing memory allocated when recording information related to a
module load.  Please merge for v5.19.

Thanks,
-Paul

--
The following changes since commit b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3=
:

 Linux 5.19-rc2 (2022-06-12 16:11:37 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
   tags/audit-pr-20220616

for you to fetch changes up to ef79c396c664be99d0c5660dc75fe863c1e20315:

 audit: free module name (2022-06-15 19:28:44 -0400)

----------------------------------------------------------------
audit/stable-5.19 PR 20220616

----------------------------------------------------------------
Christian G=C3=B6ttsche (1):
     audit: free module name

kernel/auditsc.c | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

--=20
paul-moore.com
