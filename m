Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2B858A97E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 12:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235713AbiHEKaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 06:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236199AbiHEKa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 06:30:29 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8E511162;
        Fri,  5 Aug 2022 03:30:28 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id r1-20020a05600c35c100b003a326685e7cso3728686wmq.1;
        Fri, 05 Aug 2022 03:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc;
        bh=+IEVdmP51rnzVA/x8YfipRlkpoA1oQ5jbgQSu+6DecI=;
        b=QX+4ptbOt00Pnh5p456T0hXo1mbbOetLQgh2yaE0O/bFnru5ihpFplnbLtVLZKo9dP
         RWPox3wWC28s9dBCixgjwjWFfUeTg3Tk/9U4SfbqUi2uq4LBV/M3g8eiq53AS9iFgBuC
         mVYpoBToEiB2lYSxvTsfjP4akaIdg4jbENK5xg++UyvS1NeMPrtbtaVSNLqjpXabLd1W
         NOattS1neMx8iE4kehxfJDOij2Sdy3APtbWcN+TElKppwvlYKcMR/mmgsZvemaJi+11Y
         rsjlA1hqjCavuIdxw+rHElMHMWQsLoaR+8ZsrgTR1H4hyfxjOZ57DN1/+UF6+VRzJAXi
         NO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=+IEVdmP51rnzVA/x8YfipRlkpoA1oQ5jbgQSu+6DecI=;
        b=ke5rKn/RNNZM4H6EIxJjtOv5STwjSqtdD7Yg/kgyZdsQhupVACoH90i4DkGjAZEce7
         KiK6S16er2RdHCBLJd2EUDKFjdEXGz5tKUUyE64Y99hhwmQH8UDFyBooKuT8FFPP3pCc
         5KqB6Uh2cr/htluOKQKk/Nl6prDrIQXjoFnGTlPhtJN4G9yUgxF1wSNdeH2RGRpBjj1F
         cW7K0M0hmPft3aSJ3grCJONtqjNNYME9u91pXbNuw6Y2ibqvZf3sJDfRZl/lxsfc9yW0
         MF9g1QUufipaAD8Zc4ON8EfHscrNkHYsKMr+EF6sBNPRQWsQkUL1ri2w+bsDJv5/uZix
         ArHQ==
X-Gm-Message-State: ACgBeo3nlTQ5UzBPKoAMJApx3cMaoNnECzDVxc1dwkv8q5kPSNpB8atZ
        m/sNH8lr9ZcCI0GMGCe3saUIL3DdNuA=
X-Google-Smtp-Source: AA6agR5y0uTwhEoLiv5aV1D/OQr6ZSFk/w8nrKlMpQ9AmguCqGaMlV60oTBGq0IX0fc7Uzy3FevQ8w==
X-Received: by 2002:a05:600c:4113:b0:3a3:4b67:d086 with SMTP id j19-20020a05600c411300b003a34b67d086mr8890943wmi.20.1659695426462;
        Fri, 05 Aug 2022 03:30:26 -0700 (PDT)
Received: from debian ([2405:201:8005:8149:e5c9:c0ac:4d82:e94b])
        by smtp.gmail.com with ESMTPSA id r6-20020a5d4e46000000b0021f0c05859esm3512969wrt.71.2022.08.05.03.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 03:30:25 -0700 (PDT)
Date:   Fri, 5 Aug 2022 11:30:18 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: mainline build failure due to c4371c563973 ("gpio: remove VR41XX
 related gpio driver")
Message-ID: <YuzxOoNLdE4Ejz1W@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The latest mainline kernel branch fails to build for mips tb0226_defconfig
with the error:

mipsel-linux-ld: arch/mips/pci/fixup-tb0226.o: in function `pcibios_map_irq':
fixup-tb0226.c:(.text+0x38): undefined reference to `vr41xx_set_irq_trigger'
mipsel-linux-ld: fixup-tb0226.c:(.text+0x44): undefined reference to `vr41xx_set_irq_level'
mipsel-linux-ld: fixup-tb0226.c:(.text+0x64): undefined reference to `vr41xx_set_irq_trigger'
mipsel-linux-ld: fixup-tb0226.c:(.text+0x70): undefined reference to `vr41xx_set_irq_level'
mipsel-linux-ld: fixup-tb0226.c:(.text+0xb0): undefined reference to `vr41xx_set_irq_trigger'
mipsel-linux-ld: fixup-tb0226.c:(.text+0xbc): undefined reference to `vr41xx_set_irq_level'
mipsel-linux-ld: fixup-tb0226.c:(.text+0xd4): undefined reference to `vr41xx_set_irq_trigger'
mipsel-linux-ld: fixup-tb0226.c:(.text+0xe0): undefined reference to `vr41xx_set_irq_level'
mipsel-linux-ld: fixup-tb0226.c:(.text+0xf4): undefined reference to `vr41xx_set_irq_trigger'
mipsel-linux-ld: fixup-tb0226.c:(.text+0x100): undefined reference to `vr41xx_set_irq_level'

git bisect pointed to c4371c563973 ("gpio: remove VR41XX related gpio driver")

And, reverting that commit has fixed the build failure.

I will be happy to test any patch or provide any extra log if needed.


--
Regards
Sudip
