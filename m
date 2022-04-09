Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DFD4FA6A8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 12:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240616AbiDIKHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 06:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240982AbiDIKHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 06:07:38 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF5929B7C1;
        Sat,  9 Apr 2022 03:05:30 -0700 (PDT)
Received: from localhost.localdomain ([37.4.249.94]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MvaO8-1nwR4B47S2-00sfL5; Sat, 09 Apr 2022 11:52:10 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Phil Elwell <phil@raspberrypi.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 0/2] gpiolib: of: Introduce hook for missing gpio-ranges
Date:   Sat,  9 Apr 2022 11:51:27 +0200
Message-Id: <20220409095129.45786-1-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Oa5fkx4bjn2+J48sY8Hx7pETzPyWykaUGf3Qsqu1texR7OHUIj8
 Ix9/syXJABqqE6e0/uGyBnt5FAGQFyTMEuJ/tv28VNrW5DCUHxuxmS2Pj37Co5Bzq21sdUi
 /9LTYrGPsHHgyo/NJ8NVvwpc3zOvqlUFwbs0zqb6TkQIZEW3v1mej2Cx/cCtlR0D9NQM8yA
 oE3pYIHa3MMKCsvF40qmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VSTeunK1aR0=:HebRN2Cby++pbRxZpgL7f4
 agqdxpzVz7M10/MfNnw+z2I9qjlfrKYDfG0quHedVFJglKhw9uRyS0i7XHK9ws3v3tehaTMJN
 oPVqKZyrSCcV+ounLicZSHT8vpZkD5bSjkVpeozQqycq10IW8dJwr5sykANxhaX3+ZnaTcq5H
 IPQcbFMYEEERE1CuN8RiNic7inmLQdtHomUfWmthQpvwJqdsxZ2W1qFzlfJrk0e3lBW+ITrPl
 1OI/fa3pbdZb62pubJzzrtB2wKz1O7kNVsyuv+Ui9rZ14xlI/uUzj/4QMts+2yu7xmgPIumTy
 MVS/R3wdVboBbQguV5r5Q4wKaVYozCOr91Cx98G6uDrPDjQYteUsk15+K/pLkjQMEnaNcVmF7
 AC8SSKbzmWN5WhH0k4ycenBHxYYW5raxQz/j0hwHH5fhZOtSF/qA8GuJG/KGfWqtU420XHX7I
 sn8NiBMaW6/aAutK67MbtKb31GTyh/9YLh/6Am2+PSwPMfnkZGIUOIVMmMnoADoWBOP8nEzJo
 h3j4rHaiFhxeyh484kPRuCGgLpBJzTYlVsjxQaF/UbVylra++nJ1ouTvAnISYcenADjwgL4vE
 b9cYfB0xQi1Po7aBmVSxgZTOxnQdH5+dz+ytExs0DgOHLYcrZyeEmPrgYun0Q9cQAKMFHez9L
 kfxxEbPN4xe1XqPR6A6vNjVzC8SznKPFcw2LQHhIBBGHSCr3yX0Jws0XD69idCnsdePzVFwr3
 GZLVSbmrI8cIGpfs
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series tries to provide backward compatibility for DTB which
lacks the gpio-ranges property.

The commit ("pinctrl: msm: fix gpio-hog related boot issues") by Christian
Lamparter already contains a fallback in case the gpio-ranges property
is missing. But this approach doesn't work on BCM2835 with a gpio-hog
defined for the SoC GPIOs.

Based Christian's on explanation i conclude that the fallback must happen
during the gpiochip_add() call and not afterwards. So the approach is to
call an optional hook, which can be implemented in the platform driver.

This series has been tested on Raspberry Pi 3 B Plus.

Changes since RFC:
- just add all collected Fixes, Reviewed-by, Tested-by and Acked-by

Stefan Wahren (2):
  gpiolib: of: Introduce hook for missing gpio-ranges
  pinctrl: bcm2835: implement hook for missing gpio-ranges

 drivers/gpio/gpiolib-of.c             |  5 +++++
 drivers/pinctrl/bcm/pinctrl-bcm2835.c | 18 ++++++++++++++++++
 include/linux/gpio/driver.h           | 12 ++++++++++++
 3 files changed, 35 insertions(+)

-- 
2.25.1

