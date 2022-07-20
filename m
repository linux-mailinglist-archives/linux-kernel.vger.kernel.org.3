Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADC657B996
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbiGTP23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiGTP21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:28:27 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3024E5C94E;
        Wed, 20 Jul 2022 08:28:27 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id x23-20020a05600c179700b003a30e3e7989so1516141wmo.0;
        Wed, 20 Jul 2022 08:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=cGWm2LaSnYYJYm1MyhKCb/tBTbA1ULL7NivMKT7vo5g=;
        b=JZki4U99MR4jnDGu3WD9VYGLq8lc6T41LsDK8HK9WqQMI2JLJGx7bhWduPxuAXfJxj
         bRL00sAeFABhzZ8aL3l3dVvgI9Hee/VRzZxMA9I/5IqzXad/uShfOkoqRQx+40XGb3bA
         n+hBkR/YV5dKfQb+OcCKxSJiRAy4QheRSEnJ0hgEM65xgLps8Kq9GZpVDxR3/c2A3iAF
         OvrBoVllqAe+zGeRUtUhnU5o5oyQ3YbNJQwUE71WW+0XqrGxRFdBXhSElf+F290x+67m
         T/1iURw41J4gjyQE2JjlrYNzzuVC+gEclTtjQpSq+cI7fqYJeixgsjfWCJZ9O5IWaX9j
         nBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=cGWm2LaSnYYJYm1MyhKCb/tBTbA1ULL7NivMKT7vo5g=;
        b=XoueTRn5OKvFPyxe6f3fYmzcyDi8Q8GQjRrMgGfHtPmsIHNo696orTatEo7dIW1Unb
         qEvBhgADeigwO8k2yixIphpsNuJ3zcnm5U/iKiwwWRnwZWWUAxE8WftT5GvB7XFdjIkD
         RmM8igGFVxXNlKAPViI4quSkzmXy8LsMGL0QPp7FDITaN98JQUeFb+dVFa6NyR6ouBZt
         jKThByG9mmvYh5wAIH6pOv27GdAU2+u/p7tuDO2XG/glvbAk6g28aOt2WbvdB7LBlQcB
         idPq0onXLDjnn/Tbe77HToGfX2GOu4lMKkoSjCJgBKgfiRX9LRp12iGoCBj3pFTQZHhF
         b/qg==
X-Gm-Message-State: AJIora9rZhNFN9UvGUamA6HQLY1BejGWodRHHv+mM0luoOolbxPLmoYd
        LgTuW9QVrxau7xNwlhrVtsM02gTM/0Q=
X-Google-Smtp-Source: AGRyM1s4NEvUke5pHso9W2i1NlbHT8rWEL4fwU490EIWEWwy02wvzU8hyVhKfr0Wg8PkPqlM14ljHw==
X-Received: by 2002:a05:600c:4f83:b0:3a1:9c7c:9ea3 with SMTP id n3-20020a05600c4f8300b003a19c7c9ea3mr4461800wmq.39.1658330905759;
        Wed, 20 Jul 2022 08:28:25 -0700 (PDT)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c3b8900b003a2d47d3051sm3753599wms.41.2022.07.20.08.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 08:28:25 -0700 (PDT)
Date:   Wed, 20 Jul 2022 16:28:23 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: build failure of next-20220720 due to undefined calls in modpost
Message-ID: <YtgfF/jyk6WyVLZn@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Not sure if it has been reported, builds of arm64 allmodconfig
have failed to build next-20220720 with the error:

ERROR: modpost: "free_nmi" [drivers/soc/fujitsu/a64fx-diag.ko] undefined!
ERROR: modpost: "request_nmi" [drivers/soc/fujitsu/a64fx-diag.ko] undefined!
ERROR: modpost: "enable_nmi" [drivers/soc/fujitsu/a64fx-diag.ko] undefined!


--
Regards
Sudip
