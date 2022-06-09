Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454B5545198
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 18:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344462AbiFIQLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 12:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbiFIQKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 12:10:55 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D0E1483F5;
        Thu,  9 Jun 2022 09:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding;
        bh=pQAaYG0UZr1h6O+BbSTbwI89gARYyD/qE5RN8fhYMmQ=;
        b=SBWLuViINb1MuVt8e5uaeNFyVcA/xkztNrVK3lfMyzoJr6RWZ3TiYwUzBuLYxfy+mbQqBrR6O5gRt
         dZBM/nMi102Dunnb9OE9HwqVdjgEF4b2abjokRVmVeHqbtF1+ETeFbxGj8IODSlaGg5ZPR3FPgAqJ8
         +lz9FWGSlXsOCP7dtBPbZGvpzQpXTO242IddGbM7MkUCTDg8UtEJUucmffhbSe1Dli859SsAtug47e
         IvHePKINEzRFIxXt/kYELU9OkhfzkyANkNPXO6m4ufb5ctWHZzg9tMkJxDeBbKUnqmnwVTHk/df4w1
         UJooy2QgaJicHymEogtQAmTTtQpTPWw==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.3.1424, Stamp: 3], Multi: [Enabled, t: (0.000010,0.019162)], BW: [Enabled, t: (0.000020,0.000001)], RTDA: [Enabled, t: (0.073962), Hit: No, Details: v2.40.0; Id: 15.52k9ds.1g54jmhqh.30v1; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from localhost.localdomain ([178.70.36.174])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Thu, 9 Jun 2022 19:10:28 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, corbet@lwn.net
Cc:     Ivan Bornyakov <brnkv.i1@gmail.com>, Conor.Dooley@microchip.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        system@metrotek.ru
Subject: [PATCH v17 0/4] Microchip Polarfire FPGA manager
Date:   Thu,  9 Jun 2022 18:47:48 +0300
Message-Id: <20220609154752.20781-1-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Bornyakov <brnkv.i1@gmail.com>

Add support to the FPGA manager for programming Microchip Polarfire
FPGAs over slave SPI interface with .dat formatted bitsream image.

Changelog:
  v1 -> v2: fix printk formating
  v2 -> v3:
   * replace "microsemi" with "microchip"
   * replace prefix "microsemi_fpga_" with "mpf_"
   * more sensible .compatible and .name strings
   * remove unused defines STATUS_SPI_VIOLATION and STATUS_SPI_ERROR
  v3 -> v4: fix unused variable warning
    Put 'mpf_of_ids' definition under conditional compilation, so it
    would not hang unused if CONFIG_OF is not enabled.
  v4 -> v5:
   * prefix defines with MPF_
   * mdelay() -> usleep_range()
   * formatting fixes
   * add DT bindings doc
   * rework fpga_manager_ops.write() to fpga_manager_ops.write_sg()
     We can't parse image header in write_init() because image header
     size is not known beforehand. Thus parsing need to be done in
     fpga_manager_ops.write() callback, but fpga_manager_ops.write()
     also need to be reenterable. On the other hand,
     fpga_manager_ops.write_sg() is called once. Thus, rework usage of
     write() callback to write_sg().
  v5 -> v6: fix patch applying
     I forgot to clean up unrelated local changes which lead to error on
     patch 0001-fpga-microchip-spi-add-Microchip-MPF-FPGA-manager.patch
     applying on vanilla kernel.
  v6 -> v7: fix binding doc to pass dt_binding_check
  v7 -> v8: another fix for dt_binding_check warning
  v8 -> v9:
   * add another patch to support bitstream offset in FPGA image buffer
   * rework fpga_manager_ops.write_sg() back to fpga_manager_ops.write()
   * move image header parsing from write() to write_init()
  v9 -> v10:
   * add parse_header() callback to fpga_manager_ops
   * adjust fpga_mgr_write_init[_buf|_sg]() for parse_header() usage
   * implement parse_header() in microchip-spi driver
  v10 -> v11: include missing unaligned.h to microchip-spi
     fix error: implicit declaration of function 'get_unaligned_le[16|32]'
  v11 -> v12:
   * microchip-spi: double read hw status, ignore first read, because it
     can be unreliable.
   * microchip-spi: remove sleep between status readings in
     poll_status_not_busy() to save a few seconds. Status is polled on
     every 16 byte writes - that is quite often, therefore
     usleep_range() accumulate to a considerable number of seconds.
  v12 -> v13:
   * fpga-mgr: separate fpga_mgr_parse_header_buf() from
     fpga_mgr_write_init_buf()
   * fpga-mgr: introduce FPGA_MGR_STATE_PARSE_HEADER and
     FPGA_MGR_STATE_PARSE_HEADER_ERR fpga_mgr_states
   * fpga-mgr: rename fpga_mgr_write_init_sg() to fpga_mgr_prepare_sg()
     and rework with respect to a new fpga_mgr_parse_header_buf()
   * fpga-mgr: rework write accounting in fpga_mgr_buf_load_sg() for
     better clarity
   * microchip-spi: rename MPF_STATUS_POLL_TIMEOUT to
     MPF_STATUS_POLL_RETRIES
   * microchip-spi: add comment about status reading quirk to
     mpf_read_status()
   * microchip-spi: rename poll_status_not_busy() to mpf_poll_status()
     and add comment.
   * microchip-spi: make if statement in mpf_poll_status() easier to
     read.
  v13 -> v14:
   * fpga-mgr: improvements from Xu Yilun in
      - fpga_mgr_parse_header_buf()
      - fpga_mgr_write_init_buf()
      - fpga_mgr_prepare_sg()
      - fpga_mgr_buf_load_sg()
   * fpga-mgr: add check for -EAGAIN from fpga_mgr_parse_header_buf()
     when called from fpga_mgr_buf_load_mapped()
   * microchip-spi: remove excessive cs_change from second spi_transfer
     in mpf_read_status()
   * microchip-spi: change type of components_size_start,
     bitstream_start, i from size_t to u32 in mpf_ops_parse_header()
  v14 -> v15: eliminate memcpy() in mpf_ops_write()
    Eliminate excessive memcpy() in mpf_ops_write() by using
    spi_sync_transfer() instead of spi_write().
  v15 -> v16:
   * microchip-spi: change back components_size_start and
     bitstream_start variables types to size_t, i - to u16 in
     mpf_ops_parse_header()
   * fpga-mgr: rename fpga_parse_header_buf() to
     fpga_parse_header_mapped(). It serves only mapped FPGA image now,
     adjust it accordingly.
   * fpga-mgr: separate fpga_mgr_parse_header_sg_first() and
     fpga_mgr_parse_header_sg() from fpga_mgr_prepare_sg()
  v16 -> v17:
   * microchip-spi: return size of allocated header from
     fpga_mgr_parse_header_sg(), add `char **ret_buf` to function args
     to save pointer to allocated header. This allow us to call
     fpga_mgr_write_init_buf() with exact size of allocated header.
   * document parse_header() callback in fpga-mgr.rst

Ivan Bornyakov (4):
  fpga: fpga-mgr: support bitstream offset in image buffer
  docs: fpga: mgr: document parse_header() callback
  fpga: microchip-spi: add Microchip MPF FPGA manager
  dt-bindings: fpga: add binding doc for microchip-spi fpga mgr

 .../fpga/microchip,mpf-spi-fpga-mgr.yaml      |  44 ++
 Documentation/driver-api/fpga/fpga-mgr.rst    |  31 +-
 drivers/fpga/Kconfig                          |   8 +
 drivers/fpga/Makefile                         |   1 +
 drivers/fpga/fpga-mgr.c                       | 243 +++++++++--
 drivers/fpga/microchip-spi.c                  | 393 ++++++++++++++++++
 include/linux/fpga/fpga-mgr.h                 |  17 +-
 7 files changed, 698 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
 create mode 100644 drivers/fpga/microchip-spi.c

-- 
2.35.1


