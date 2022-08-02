Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556F45882EB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 22:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbiHBUHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 16:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiHBUHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 16:07:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A1552455;
        Tue,  2 Aug 2022 13:07:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9AF08B8205F;
        Tue,  2 Aug 2022 20:07:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE374C433C1;
        Tue,  2 Aug 2022 20:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659470823;
        bh=HwCCgESqSTo/2CN28EWAYXXLjrse6e9dUQkjjom2q+M=;
        h=From:To:Cc:Subject:Date:From;
        b=mfDIeQT+Iu2H0brjp1DrXu6A3zhjPEh/l5DPTIwo/nvPaOMOWSDgHSEL8Ubye6+cI
         lnzNEd2GvHY1k6P4wpip0k229b5O/qrhqt7o5RP0Idiu3EcA2QrPaLoEThFnaafVqt
         X56WfBhqYmSz2OGgZMkKPTOzo07EguGA0omO7OeMHC1nJzz81de06Mt2vB9///TLLN
         9VGpIZ42XaFUreDLhp0H7m4yuuObTRRsNXGjMZyJ9N7Xl0HFLWGxY1bz7AMO5ia7/2
         d12o7pvtD49M4R8Zc0JT70TBL9dHjXT+Gev94pWBiFkVDd3ljjT5/o+dTSVvH61ak3
         gmHNV4ArRvFng==
From:   broonie@kernel.org
To:     Greg KH <greg@kroah.com>, Douglas Anderson <dianders@chromium.org>,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: linux-next: build failure after merge of the tty tree
Date:   Tue,  2 Aug 2022 21:06:49 +0100
Message-Id: <20220802200649.2122084-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

After merging the tty tree, today's linux-next build (x86 allmodconfig)
failed like this:

In file included from /tmp/next/build/include/linux/device.h:15,
                 from /tmp/next/build/include/linux/node.h:18,
                 from /tmp/next/build/include/linux/cpu.h:17,
                 from /tmp/next/build/include/linux/of_device.h:5,
                 from /tmp/next/build/drivers/tty/serial/qcom_geni_serial.c:14:
/tmp/next/build/drivers/tty/serial/qcom_geni_serial.c: In function 'qcom_geni_serial_set_termios':
/tmp/next/build/drivers/tty/serial/qcom_geni_serial.c:1039:4: error: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'unsigned int' [-Werror=format=]
 1039 |    "Couldn't find suitable clock rate for %lu\n",
      |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/tmp/next/build/include/linux/dev_printk.h:110:16: note: in definition of macro 'dev_printk_index_wrap'
  110 |   _p_func(dev, fmt, ##__VA_ARGS__);   \
      |                ^~~
/tmp/next/build/include/linux/dev_printk.h:144:49: note: in expansion of macro 'dev_fmt'
  144 |  dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
      |                                                 ^~~~~~~
/tmp/next/build/drivers/tty/serial/qcom_geni_serial.c:1038:3: note: in expansion of macro 'dev_err'
 1038 |   dev_err(port->se.dev,
      |   ^~~~~~~
/tmp/next/build/drivers/tty/serial/qcom_geni_serial.c:1039:45: note: format string is defined here
 1039 |    "Couldn't find suitable clock rate for %lu\n",
      |                                           ~~^
      |                                             |
      |                                             long unsigned int
      |                                           %u
In file included from /tmp/next/build/include/linux/printk.h:573,
                 from /tmp/next/build/include/linux/kernel.h:29,
                 from /tmp/next/build/include/linux/clk.h:13,
                 from /tmp/next/build/drivers/tty/serial/qcom_geni_serial.c:7:
/tmp/next/build/drivers/tty/serial/qcom_geni_serial.c:1044:24: error: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'unsigned int' [-Werror=format=]
 1044 |  dev_dbg(port->se.dev, "desired_rate-%lu, clk_rate-%lu, clk_div-%u\n",
      |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/tmp/next/build/include/linux/dynamic_debug.h:134:15: note: in definition of macro '__dynamic_func_call'
  134 |   func(&id, ##__VA_ARGS__);  \
      |               ^~~~~~~~~~~
/tmp/next/build/include/linux/dynamic_debug.h:166:2: note: in expansion of macro '_dynamic_func_call'
  166 |  _dynamic_func_call(fmt,__dynamic_dev_dbg,   \
      |  ^~~~~~~~~~~~~~~~~~
/tmp/next/build/include/linux/dev_printk.h:155:2: note: in expansion of macro 'dynamic_dev_dbg'
  155 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~
/tmp/next/build/include/linux/dev_printk.h:155:23: note: in expansion of macro 'dev_fmt'
  155 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
      |                       ^~~~~~~
/tmp/next/build/drivers/tty/serial/qcom_geni_serial.c:1044:2: note: in expansion of macro 'dev_dbg'
 1044 |  dev_dbg(port->se.dev, "desired_rate-%lu, clk_rate-%lu, clk_div-%u\n",
      |  ^~~~~~~
/tmp/next/build/drivers/tty/serial/qcom_geni_serial.c:1044:40: note: format string is defined here
 1044 |  dev_dbg(port->se.dev, "desired_rate-%lu, clk_rate-%lu, clk_div-%u\n",
      |                                      ~~^
      |                                        |
      |                                        long unsigned int
      |                                      %u

Caused by commit

  c474c775716edd46a5 ("tty: serial: qcom-geni-serial: Fix get_clk_div_rate() which otherwise could return a sub-optimal clock rate.")

I have used the tree from 20220727 instead.
