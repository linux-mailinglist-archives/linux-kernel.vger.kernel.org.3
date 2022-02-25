Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A324C3FC2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 09:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238372AbiBYIJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 03:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238366AbiBYIJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 03:09:37 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Feb 2022 00:09:03 PST
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9612A82D1D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 00:09:03 -0800 (PST)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2022022508075884706c0963ab344f05
        for <linux-kernel@vger.kernel.org>;
        Fri, 25 Feb 2022 09:07:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=/4YsYMzxGvUqIQBjTEP/XQJ98gM/OKteuKxCDp9Dg40=;
 b=RuPWmdOKnZmPnTz3nAA0N/4wXomoRHUZOFCuf9m7vWEE4ZSOWckAJuG7LNg9WQ4iqgfLW5
 9q1wjTrksQCeIBrtnD2tw9LAgWKqwKKww2z9/xubuwq+Q44awYiezZufmPK7w3hPG0eFGgGY
 Br4i2uPT/P+Gaz5IFxpsJ8BrP2QKo=;
From:   Daniel Starke <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [RFC 0/1] tty: n_gsm: improve standard compliance and feature completeness
Date:   Fri, 25 Feb 2022 00:07:57 -0800
Message-Id: <20220225080758.2869-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-118192:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We as Siemens Mobility GmbH are using the n_gsm module as specified by
3GPP 27.010 and required by UNISIG SUBSET-037 chapter 6 of the European
train control system standard to establish multiple parallel connections to
GSM-R radio mobiles as used in our communication system.
This is needed to handle CS (circuit switched) and PS (packet switched)
services and functions in parallel. It requires at least four multiplexed
data link connections (DLCs), including the control channel. It also
requires the use of convergence layer type 2 in advanced option mode.

We have improved support for this use case and the overall stability of the
driver to achieve this. The modified driver was extensively tested and is
already included in our productive system. We have integrated it with
mobiles from Funkwerk Systems GmbH and Triorail Bahnfunk GmbH.
A rough summary of changes made can be found below. The patch presented
here shall provide a first impression of the planned upcoming commits and
allow others to test and comment on these at an early stage. We plan to
separate these changes and commit smaller change sets of this. But this
is still work in progress.

Our motivation of this commitment to the community lies in a smoother
migration to upcoming kernel versions, a broader use for a better test
coverage and an overall better quality of the driver. In a first step a set
of bug fixes unrelated to the new functions has already been committed.

[CR] Changes included:
[1] added: proper n_gsm Kernel module information fields and module version
[2] added: optional start-of-frame flag skipping in advanced option mode
[3] added: UI (unnumbered information) frame support
[4] added: PN (parameter negotiation) message handling and function support
[5] added: optional keep-alive control link supervision via Test messages
[6] added: proc fs files to provide meta data for the n_gsm instances
[7] added: various parameter gated kernel debug messages
[8] added: option for strict mode to reject non-standard compliant behavior
[9] added: TIOCM_OUT1 and TIOCM_OUT2 to allow responder to operate as modem
[10] added: TIOCMIWAIT support on virtual ttys
[11] added: additional ioctls and parameters to configure the new functions
[12] added: more function comments and aligned all to the coding guidelines
[13] changed: overall locking mechanism to avoid data race conditions
[14] changed: outgoing data flow to decouple physical from virtual tty
     handling for better performance and to avoid dead-locks
[15] fixed: advanced option mode implementation
[16] fixed: convergence layer type 2 implementation
[17] fixed: handling of CLD (multiplexer close down) messages
[18] fixed: broken muxer close down procedure

[NO] Points that remain open and are out of scope here:
[1] DLCI priority handling according to the configured values. The priority
    is currently only handled according to the DLCI number.
[2] correct flow control handling (the standard is ambiguous, ch. 5.4.8.1)
[3] combined opening and closing flag handling in basic option mode
    (ch. 5.2.6.1; the data can be ambiguous)
[4] power control services (ch. 5.1.5 and 5.4.7)
[5] error recovery mode option (ch. 6)
[6] convergence layer type 3 and 4 (ch. 5.5.3 and 5.5.4)
[7] remote port negotiation (ch. 5.1.8.2.1 and 5.4.6.3.9)
[8] service negotiation (ch. 5.1.8.1.2 and 5.4.6.3.11)

The referenced chapters can be found in 3GPP TS 27.010. See link below.

[X] Furthermore, the following commits conflict with this implementation:
[1] commit 509067bbd264 ("tty: n_gsm: Delete gsm_disconnect when config requester")
[2] commit 5b87686e3203 ("tty: n_gsm: Modify gsmtty driver register method when config requester")
[3] commit 0b91b5332368 ("tty: n_gsm: Save dlci address open status when config requester")
[4] commit 46292622ad73 ("tty: n_gsm: clean up indenting in gsm_queue()")

[X1] conflicts with the new implementation for parameter negotiation.
[X2], [X3] and [X4] implement dynamic virtual tty registration to allow
uevents on the responder side. However, on responder side an application
may first want to configure the link before it is established. That is why
the virtual ttys need to be available directly after the control channel
establishment. The responder still gets informed about a line open by
waiting for DTR (data terminal ready) to be set. Just like on a physical
serial interface.

Please provide comments and hints for the integration of these changes into
the upcoming Linux kernel. Feel free to refer to specific points by the
given identifier (e.g. CR11 for TIOCMIWAIT support).

With best regards,
Daniel Starke

Link: https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1516
Link: https://www.era.europa.eu/sites/default/files/filesystem/ertms/ccs_tsi_annex_a_-_mandatory_specifications/set_of_specifications_3_etcs_b3_r2_gsm-r_b1/index010_-_subset-037_v320.pdf

Daniel Starke (1):
  tty: n_gsm: improve standard compliance and feature completeness

 drivers/tty/n_gsm.c         | 4523 +++++++++++++++++++++++++----------
 include/uapi/linux/gsmmux.h |   70 +-
 2 files changed, 3364 insertions(+), 1229 deletions(-)

-- 
2.25.1

