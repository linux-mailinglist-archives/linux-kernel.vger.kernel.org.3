Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD89499A30
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 22:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1457555AbiAXVlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 16:41:51 -0500
Received: from mout.gmx.net ([212.227.15.18]:50771 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1445736AbiAXVEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 16:04:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643058269;
        bh=Ec1E+XVbmVaZkoonfqus3Ied9jzwitQE64DgeYRcJ58=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=SXmhUWQ1CRWaNWJ9KeqXwp3cEMR4JpqMknuHKQTpE2Ku65iaeIz0Kq7Sn8V2KzFLK
         XC2EVFoL2fI+8sb0leh3Ou1NfBsnomk8UH747CkEDXleOwmXqV5sJuDM4eLZIUl1we
         aIFuEWrexXiwOCzd1005n4PkEweyW+CWl1iH2p2w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.165.96]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgeoI-1me8CO3qrE-00h5pr; Mon, 24
 Jan 2022 22:04:29 +0100
From:   Helge Deller <deller@gmx.de>
To:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Sven Schnelle <svens@stackframe.org>,
        Claudio Suarez <cssk@net-c.es>, Pavel Machek <pavel@ucw.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH v2 0/2] Fix regression introduced by disabling accelerated scrolling in fbcon
Date:   Mon, 24 Jan 2022 22:03:17 +0100
Message-Id: <20220124210319.325512-1-deller@gmx.de>
X-Mailer: git-send-email 2.31.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6FEDwYEykD2AOXr/nEQNj6xwhFHj/FdHKryvnHfF3emq2u1Ux8U
 SCBo/ypmBPN+TerQ3D8Vdyf+RD/HISBfpRglhojRAnBRGWsI1IFxN1J8e50EJu8PqYDo9kR
 tvi5lRY6NDsqmqVlxWTQpkwsJbBXtdKMXADp7LtZ8UVFk96aC+croFew1lnMVWnKaf8dG0r
 PsRdWUYwHaES2Yfi6MjHg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lgwjfMC5XkQ=:w2BWauQ+JigdFMoVP/KZ+w
 HWFXAax0fMJH+uM6gdbk8RtDmh1Pb8iYZKn1XtEvXpM9zLTpxeYqRN2DBMTDGEdj274GZtvbJ
 sluAuboGYPFvyINtfXYM7R8f/yPF3fm1RqMAExGFqmcax05mrLHSi+Gg3FzTb7gHzi0R2pdv/
 rQAXHG1SVZUIRaOT9fvuyCUxOx9hev+6ntoj9XY1Uuai2KeFykEDxUUugEqivyG/QGQQSOb57
 fzoSDYM4N/NYiEAhD//QEV5/0gaOOWIQA7KveGSRiqzEIBdL+X73yWWqVhBMl2Wq+FKLFC3u1
 vRERligauulv/2sFsQ8zT0d1d3BaX8+MAyWGjXOmSflk4mX5qRh3Uj1YMS4fSog/wbL/D5aJT
 2+IRnEVvTieyVagL9mPBmnxFplt5s1JQZzUcMi4IItvT3/ymdEsZmV1nmnUdTtzzq6Z3f6iW4
 TEexfwLvQLXIJK7WRvRqNj0GV1kF/UrlX5hfTyQ+5OfuJn1fr2+oHpTMVYWd4QGOPUpgXZUY1
 mJYXZCAvJjzB/Lmic+azvkck5qYUZcuj3DL/DzbJHsVEPnnJSbPx/T4jKFSENpcFR3wo2Pycn
 ZsqIHBjMJT2PIrtJ5G/iuOfZz/PmpKdN7Cq2BB2evYcipAYqXqg25tSIIgy3Rw7H7ecfA/Gio
 x/6pog60QXv/ROTgSADpCryr6uielpB3ufFAKhZ26EmWze3myfRpOhjHMEiozm1DQpJZM5GO9
 /2G5wrX496KA2ckmwVffqpoksH1A4aEBUrMrEtnaXqtsmdVcY+WK33Uzt37H/StUKJ1c+mUui
 fGoyT7rU2M7UafTuVkH2M2s+lohQnPJA/ZOEzAcNRWCHdJ+lIRvUeOUGCdaDOGDKtPd1hJQge
 kVFR7nepF+CFn9gualAvrzsvu+jgdHVaWBRE7WGWqSlqBcmyBjKyQOSThp67qyCODIwDSRl/c
 LYHFvu2x8KJwu3nnI17o7ZgH0dqy5fhYQ/1pHvFpKrUR1amSn9JHCLywJHt4pjVOBlsW7colX
 Bph4YuajvA5p5DIvOjphiTPQ14HjpZWJBPxliTcEIY3DLWmwdzDmTkhnJK6LQjAN2k664RA+k
 XfWcd2KXUPC8Vc=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series reverts two patches which disabled scrolling acceleration in=0D
fbcon/fbdev. Those patches introduced a regression for fbdev-supported grap=
hic=0D
cards because of the performance penalty by doing screen scrolling by softw=
are=0D
instead of using existing 2D hardware acceleration.=0D
=0D
This series has been discussed on linux-fbdev, dri-devel and linux-kernel=0D
mailing lists. The consensus is that they will be reverted, but in addition=
=0D
it's being worked on to find a solution which allows to disable parts of th=
e=0D
classic fbdev hardware acceleration code which isn't needed in DRM-only=0D
configurations.=0D
=0D
The patchset is planned to be kept in fbdev's for-next git branch and later=
=0D
pushed into kernel v5.18 if no issues are found until then.=0D
=0D
Helge=0D
=0D
---=0D
Changes in v2 compared to v1:=0D
- adjusted the stable tags (one v5.10+, the other v5.16+)=0D
- moved the analysis and reasoning why those should be reverted into=0D
  the commit message. That simplifies to analyze later why they were=0D
  reverted.=0D
- resorted the To an Cc mail recipient lists=0D
=0D
Helge Deller (2):=0D
  Revert "fbdev: Garbage collect fbdev scrolling acceleration, part 1=0D
    (from TODO list)"=0D
  Revert "fbcon: Disable accelerated scrolling"=0D
=0D
 Documentation/gpu/todo.rst              |  24 --=0D
 drivers/video/fbdev/core/bitblit.c      |  16 +=0D
 drivers/video/fbdev/core/fbcon.c        | 540 +++++++++++++++++++++++-=0D
 drivers/video/fbdev/core/fbcon.h        |  59 +++=0D
 drivers/video/fbdev/core/fbcon_ccw.c    |  28 +-=0D
 drivers/video/fbdev/core/fbcon_cw.c     |  28 +-=0D
 drivers/video/fbdev/core/fbcon_rotate.h |   9 +=0D
 drivers/video/fbdev/core/fbcon_ud.c     |  37 +-=0D
 drivers/video/fbdev/core/tileblit.c     |  16 +=0D
 drivers/video/fbdev/skeletonfb.c        |  12 +-=0D
 include/linux/fb.h                      |   2 +-=0D
 11 files changed, 703 insertions(+), 68 deletions(-)=0D
=0D
-- =0D
2.31.1=0D
=0D
