Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E31E476A54
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 07:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbhLPGY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 01:24:26 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:37719 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbhLPGYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 01:24:25 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JF2Bt2WF0z4xcF;
        Thu, 16 Dec 2021 17:24:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
        s=201707; t=1639635862;
        bh=ghasrMJ0LZ4YSU1neyhcBbY1k4hx8y4S1Ymf9h54RE8=;
        h=From:To:Cc:Subject:Date:From;
        b=iYios6p4f8Y9HAjFiMZdF3Jqbtpa/VZ+CDgof4kNUoy5TsbYh9ZI0GoV0g1l0XaO2
         2M4hg+CkscgBzySlbt7e+NvmC/WhVX5Yw4j7BgpMpH+tnoe8g53iwiN+p6jrczMhse
         OcUq5NPrYr2oK72zIY2p4+9japZOZkKBGflUBCVn/YHPasjL7oo5ah4OlwXHPEGBq8
         U20wRjV7XmbXqsMtJqfCGfVruayChlyCssJCE6oaLTdtUfkKToxBXoBNBhrZ8aNkAT
         5Nde5cJ89DeHRolWcztyQrcffIBNMHHREkvm4joPWsoVQTp7IX0qD2/h8EsEVfCK11
         ud6XheKZsFVSQ==
From:   Amitay Isaacs <amitay@ozlabs.org>
To:     linux-kernel@vger.kernel.org, linux-fsi@lists.ozlabs.org,
        jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        eajames@linux.ibm.com
Cc:     Amitay Isaacs <amitay@ozlabs.org>
Subject: [PATCH v2 0/2] Enable read timeout specification for sbefifo read
Date:   Thu, 16 Dec 2021 17:24:03 +1100
Message-Id: <20211216062405.415888-1-amitay@ozlabs.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain SBE operations (e.g. collecting trace information from processors)
can take long time (> 10 seconds) to finish before SBE can respond.
Such operations will currentlly timeout due to the default response
timeout of 10 seconds.  This patchset allows users to set a longer timeout
using ioctl on the sbefifo device fd, before issuing SBE operations that
are likely to take longer.

v2 changes:
  - uint32 --> u32
  - Avoid resetting the read timeout after single operation.  Use ioctl
    to set the read timeout per open fd for sbefifo device.
  - Specifying 0 value to ioctl will reset the timeout to default value
  - Document ioctl behaviour in uapi/linux/fsi.h


Amitay Isaacs (2):
  fsi: sbefifo: Use specified value of start of response timeout
  fsi: sbefifo: implement FSI_SBEFIFO_READ_TIMEOUT ioctl

 drivers/fsi/fsi-sbefifo.c | 48 ++++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/fsi.h  | 14 ++++++++++++
 2 files changed, 61 insertions(+), 1 deletion(-)

-- 
2.33.1

