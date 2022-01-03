Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F05483758
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235972AbiACTD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235959AbiACTDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:03:55 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A0BC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:03:54 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id y22so139446033edq.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/2JEOCUCGzzKmkzKgD9tpqsM2aLNkAEcT88f23wY2bA=;
        b=JLeOr+J+M8DUT40vwroGazDnni2GSIRt+UK1Wan7DZyOexyDU/YQmk+dEpf1qCIKvB
         sdi3N1GEBVzmp4k1JV0PXO2EuYlQRgz71448OTfOqlCGXefWb6N9QIY9GWGjUSRNOFhP
         RH5vshF/o3KwBxgHdTu8YG8n6BKE93ODWFKIJIFCVDaRDgX+gFlSbUfHkg/NFwIEmboj
         5Lw+0lJtvv+9POGBZs5AJIdyrwrfkdm6NRp6KJ6ZBdXZDkhWirn4l2M0fjbnI9tpY0xN
         9JSfDSWLFcO45YJiIfRY9bAPmjLBHAL74PdQKv2aIKZnVy5A1SeMwR7kzfBJnPJ1bZIf
         5riQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/2JEOCUCGzzKmkzKgD9tpqsM2aLNkAEcT88f23wY2bA=;
        b=rIyh3h/jdNdy7UtMnJJiFC7He6G64Wgpm680fDLPqvqaaQNSjC/lWNNSsfd6foPfEz
         I2GXMTmu8iyI0KrivmIEbkOi7wi6BfSstzxV7Jh2sK98YYuekx9LQ3cQf+wLjJy1Q6uR
         Jnyp3/PUJ5F3EMOkZ/uy68kOfdO3A4lKw9KNRbhsGAGUSdtbHEnRsN0cCYJaNBPa+pLf
         ++2HODf+O374SQg8yTL78ISg+sDYjBhZytHd1mnW3iqYc+lBrWtmDjcEDowZBoPSwYno
         hrNnezAejyA7zjHnFE+2GhV3VPlxJZU07LR6wBMk1WiUxwZEpK8FnEDpCp4oDC1VSU11
         Q7lg==
X-Gm-Message-State: AOAM533BCr5jfBacUJCPL2Qw75l5IdlOavnjwrDF8caZ48B4jEBkBIT/
        fRjfYw3NOFFJUMUqan7vMU4=
X-Google-Smtp-Source: ABdhPJxiUJjU/vUyAMmqdJdmitcqB1YdVBA/hEU4Fn+S8yy51xeZfvNormw4/e36RadlSSTBpBFhow==
X-Received: by 2002:a05:6402:34c6:: with SMTP id w6mr46365324edc.284.1641236633574;
        Mon, 03 Jan 2022 11:03:53 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:03:53 -0800 (PST)
From:   Alberto Merciai <alb3rt0.m3rciai@gmail.com>
Cc:     alb3rt0.m3rciai@gmail.com, linuxfancy@googlegroups.com,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Ivan Safonov <insafonov@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Zameer Manji <zmanji@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/56] staging: r8188eu: wifi.h macros refactoring
Date:   Mon,  3 Jan 2022 20:01:35 +0100
Message-Id: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series refactors most of the macros inside
include/wifi.h making them compliant with linux coding style.

Main changes are related to the following issues:
- Avoid CamelCase
- Remove dead code
- Macros with complex values should be enclosed in parentheses

Alberto Merciai (56):
  staging: r8188eu: add parenthesis to macro SetToDs
  staging: r8188eu: rename camelcase SetToDs to set_to_ds
  staging: r8188eu: remove dead macro ClearToDs
  staging: r8188eu: add parenthesis to macro SetFrDs
  staging: r8188eu: rename camelcase SetFrDs to set_fr_ds
  staging: r8188eu: remove dead macro ClearFrDs
  staging: r8188eu: add parenthesis to macro SetMFrag
  staging: r8188eu: rename camelcase SetMFrag to set_m_frag
  staging: r8188eu: rename camelcase GetToDs to get_to_ds
  staging: r8188eu: rename camelcase GetFrDs to get_fr_ds
  staging: r8188eu: rename camelcase GetMFrag to get_m_frag
  staging: r8188eu: rename camelcase ClearMFrag to clear_m_frag
  staging: r8188eu: add parenthesis to macro clear_m_frag
  staging: r8188eu: remove dead macro SetRetry
  staging: r8188eu: rename camelcase GetRetry to get_retry
  staging: r8188eu: remove dead macro ClearRetry
  staging: r8188eu: rename camelcase SetPwrMgt to set_pwr_mgt
  staging: r8188eu: add parenthesis to macro set_pwr_mgt
  staging: r8188eu: rename camelcase GetPwrMgt to get_pwr_mgt
  staging: r8188eu: remove dead macro ClearPwrMgt
  staging: r8188eu: rename camelcase SetMData to set_m_data
  staging: r8188eu: add parenthesis to macro set_m_data
  staging: r8188eu: rename camelcase GetMData to get_m_data
  staging: r8188eu: remove dead macro ClearMData
  staging: r8188eu: rename camelcase SetPrivacy to set_privacy
  staging: r8188eu: add parenthesis to macro set_privacy
  staging: r8188eu: rename camelcase GetPrivacy to get_privacy
  staging: r8188eu: remove dead macro ClearPrivacy
  staging: r8188eu: rename camelcase GetOrder to get_order
  staging: r8188eu: rename camelcase GetFrameType to get_frame_type
  staging: r8188eu: remove dead macro SetFrameType
  staging: r8188eu: rename camelcase GetFrameSubType to
    get_frame_subtype
  staging: r8188eu: rename camelcase SetFrameSubType to
    set_frame_subtype
  staging: r8188eu: rename camelcase GetSequence to get_sequence
  staging: r8188eu: rename camelcase GetFragNum to get_frag_num
  staging: r8188eu: remove dead macro GetTupleCache
  staging: r8188eu: remove dead macro SetFragNum
  staging: r8188eu: rename camelcase SetSeqNum to set_seq_num
  staging: r8188eu: rename camelcase SetDuration to set_duration
  staging: r8188eu: rename camelcase SetPriority to set_priority
  staging: r8188eu: add parenthesis to macro set_duration
  staging: r8188eu: add parenthesis to macro set_priority
  staging: r8188eu: rename camelcase GetPriority to get_priority
  staging: r8188eu: rename camelcase SetEOSP to set_eosp
  staging: r8188eu: add parenthesis to macro set_eosp
  staging: r8188eu: remove dead macro GetTid
  staging: r8188eu: rename camelcase SetAckpolicy to set_ack_policy
  staging: r8188eu: add parenthesis to macro set_ack_policy
  staging: r8188eu: rename camelcase GetAckpolicy into get_ack_policy
  staging: r8188eu: rename camelcase GetAMsdu to get_a_msdu
  staging: r8188eu: remove dead macro SetAMsdu
  staging: r8188eu: rename camelcase GetAid to get_aid
  staging: r8188eu: rename camelcase GetAddr1Ptr to get_addr_1_ptr
  staging: r8188eu: rename camelcase GetAddr2Ptr to get_addr_2_ptr
  staging: r8188eu: rename camelcase GetAddr3Ptr to get_addr_3_ptr
  staging: r8188eu: rename camelcase GetAddr4Ptr to get_addr_4_ptr

 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 190 +++++++++---------
 drivers/staging/r8188eu/core/rtw_p2p.c        |  24 +--
 drivers/staging/r8188eu/core/rtw_recv.c       |  78 +++----
 drivers/staging/r8188eu/core/rtw_security.c   |   8 +-
 drivers/staging/r8188eu/core/rtw_wlan_util.c  |   4 +-
 drivers/staging/r8188eu/core/rtw_xmit.c       |  22 +-
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c    |  30 +--
 drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c |   2 +-
 drivers/staging/r8188eu/include/wifi.h        | 167 ++++++---------
 9 files changed, 240 insertions(+), 285 deletions(-)

-- 
2.25.1

