Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E17538952
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 02:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241640AbiEaAoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 20:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbiEaAoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 20:44:34 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1B39345E;
        Mon, 30 May 2022 17:44:31 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LBtp23Dxbz4xD9;
        Tue, 31 May 2022 10:44:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1653957866;
        bh=JC7BPNWG+EnTDRz5/K2ihsUi0zTN1Wi3be1wmmMiVFI=;
        h=Date:From:To:Cc:Subject:From;
        b=sanfA/+migbDenKrCHZhRogzkOpsPUx120uTeLoW5MCwa6B4VokVwXj5hovlnF5Ap
         xcen0yByzCtUTzJFL5j4veh2hEM4hKlqR+SHtddiDg+D/HZKNOyHTxQf8OFblgixev
         I337o+oqCQYouXIw+U3MEYTp7iMHBIwn825h4Kz/7zZU0H1nVAijHNLi730i9GVec6
         un8RMEINqYpr2bOoTApmN/L8zcQFllfJWmgJXD27pQQN/xbh1rdvIIfCWx7IzBHwvE
         TuIM4HlkD95AHed5Egoq5Udiqv4ftxOKkPzHVaLWDt3cH6JX8ys1HbM2ZrO0J4hq+S
         39c1+F/0xvi9A==
Date:   Tue, 31 May 2022 10:44:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the tomoyo tree
Message-ID: <20220531104424.0a467ba4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xcY=yEXSC9hogFAS8JD8uYT";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xcY=yEXSC9hogFAS8JD8uYT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tomoyo tree, today's linux-next build (powerpc
ppc64_defconfig) produced these warnings:

drivers/scsi/mpt3sas/mpt3sas_scsih.c: In function 'scsih_suspend':
drivers/scsi/mpt3sas/mpt3sas_scsih.c:12412:9: note: '#pragma message: Pleas=
e avoid flushing system-wide workqueues.'
12412 |         flush_scheduled_work();
      |         ^~~~~~~~~~~~~~~~~~~~
drivers/scsi/qla2xxx/qla_target.c: In function 'qlt_stop_phase1':
drivers/scsi/qla2xxx/qla_target.c:1566:17: note: '#pragma message: Please a=
void flushing system-wide workqueues.'
 1566 |                 flush_scheduled_work();
      |                 ^~~~~~~~~~~~~~~~~~~~
drivers/md/dm.c: In function 'local_exit':
drivers/md/dm.c:246:9: note: '#pragma message: Please avoid flushing system=
-wide workqueues.'
  246 |         flush_scheduled_work();
      |         ^~~~~~~~~~~~~~~~~~~~

Introduced by commit

  48d1646a0262 ("workqueue: Wrap flush_scheduled_work() using a macro")

Also, my x86_64 allmodconfig build gained these:

drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c: In function 'cdns_mhdp=
_remove':
drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c:2606:9: note: '#pragma =
message: Please avoid flushing system-wide workqueues.'
 2606 |         flush_scheduled_work();
      |         ^~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/bridge/lontium-lt9611uxc.c: In function 'lt9611uxc_remove':
drivers/gpu/drm/bridge/lontium-lt9611uxc.c:985:9: note: '#pragma message: P=
lease avoid flushing system-wide workqueues.'
  985 |         flush_scheduled_work();
      |         ^~~~~~~~~~~~~~~~~~~~
drivers/message/fusion/mptscsih.c: In function 'mptscsih_suspend':
drivers/message/fusion/mptscsih.c:1234:9: note: '#pragma message: Please av=
oid flushing system-wide workqueues.'
 1234 |         flush_scheduled_work();
      |         ^~~~~~~~~~~~~~~~~~~~
drivers/net/wireless/ath/ath6kl/usb.c: In function 'ath6kl_usb_flush_all':
drivers/net/wireless/ath/ath6kl/usb.c:481:9: note: '#pragma message: Please=
 avoid flushing system-wide workqueues.'
  481 |         flush_scheduled_work();
      |         ^~~~~~~~~~~~~~~~~~~~
In file included from drivers/gpu/drm/i915/gt/intel_execlists_submission.c:=
4112:
drivers/gpu/drm/i915/gt/selftest_execlists.c: In function 'wait_for_reset':
drivers/gpu/drm/i915/gt/selftest_execlists.c:88:9: note: '#pragma message: =
Please avoid flushing system-wide workqueues.'
   88 |         flush_scheduled_work();
      |         ^~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/i915/display/intel_display.c: In function 'intel_modeset_dr=
iver_remove_noirq':
drivers/gpu/drm/i915/display/intel_display.c:10502:9: note: '#pragma messag=
e: Please avoid flushing system-wide workqueues.'
10502 |         flush_scheduled_work();
      |         ^~~~~~~~~~~~~~~~~~~~
drivers/scsi/qla2xxx/qla_target.c: In function 'qlt_stop_phase1':
drivers/scsi/qla2xxx/qla_target.c:1566:17: note: '#pragma message: Please a=
void flushing system-wide workqueues.'
 1566 |                 flush_scheduled_work();
      |                 ^~~~~~~~~~~~~~~~~~~~
drivers/rtc/dev.c: In function 'clear_uie':
drivers/rtc/dev.c:99:25: note: '#pragma message: Please avoid flushing syst=
em-wide workqueues.'
   99 |                         flush_scheduled_work();
      |                         ^~~~~~~~~~~~~~~~~~~~
drivers/scsi/mpt3sas/mpt3sas_scsih.c: In function 'scsih_suspend':
drivers/scsi/mpt3sas/mpt3sas_scsih.c:12412:9: note: '#pragma message: Pleas=
e avoid flushing system-wide workqueues.'
12412 |         flush_scheduled_work();
      |         ^~~~~~~~~~~~~~~~~~~~
drivers/md/dm.c: In function 'local_exit':
drivers/md/dm.c:246:9: note: '#pragma message: Please avoid flushing system=
-wide workqueues.'
  246 |         flush_scheduled_work();
      |         ^~~~~~~~~~~~~~~~~~~~
drivers/platform/surface/surface_acpi_notify.c: In function 'san_remove':
drivers/platform/surface/surface_acpi_notify.c:864:9: note: '#pragma messag=
e: Please avoid flushing system-wide workqueues.'
  864 |         flush_scheduled_work();
      |         ^~~~~~~~~~~~~~~~~~~~
drivers/rapidio/devices/tsi721.c: In function 'tsi721_remove':
drivers/rapidio/devices/tsi721.c:2944:9: note: '#pragma message: Please avo=
id flushing system-wide workqueues.'
 2944 |         flush_scheduled_work();
      |         ^~~~~~~~~~~~~~~~~~~~
drivers/iio/light/tsl2563.c: In function 'tsl2563_remove':
drivers/iio/light/tsl2563.c:811:9: note: '#pragma message: Please avoid flu=
shing system-wide workqueues.'
  811 |         flush_scheduled_work();
      |         ^~~~~~~~~~~~~~~~~~~~

Linus will not be happy ...
--=20
Cheers,
Stephen Rothwell

--Sig_/xcY=yEXSC9hogFAS8JD8uYT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKVZOgACgkQAVBC80lX
0GzYvAf8CitAvoxy1Aw5bxsderGUJOcmp8oMt0Oh397fz0gXYw3G1Uxz9rCNY/IY
En9F3NCfKl1/AYlLGdm9WVDSkOaZYiAE8oyH94GvpmUI3mrjmZLCb02ymGh35xBq
nAROhvLbJMZcEtdf1C/R8thohTzjcrzwEScGpTANYKiNGYMrPeavjsTSFsaKybe+
ilLFCfzrfRa1lt9c2ulWXANinXTNjXOpbZIoO85qsZGYS++1okx1uhcTsD1OItJz
BFtVnbpAxv0zlI7eiXfn0Q4COykD+OZRduUOftbgVlQF7ioA/lf90OBDH+/LayQf
hPePepGTQbOrgHenrO/aDxHLnGV4LQ==
=RJiW
-----END PGP SIGNATURE-----

--Sig_/xcY=yEXSC9hogFAS8JD8uYT--
