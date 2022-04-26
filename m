Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C07251067A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353662AbiDZSSA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Apr 2022 14:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345587AbiDZSR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:17:59 -0400
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1EC088791;
        Tue, 26 Apr 2022 11:14:47 -0700 (PDT)
Received: from smtpclient.apple (p4fefc174.dip0.t-ipconnect.de [79.239.193.116])
        by mail.holtmann.org (Postfix) with ESMTPSA id EFA46CECE1;
        Tue, 26 Apr 2022 20:14:46 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH v1] Bluetooth: btusb: Set
 HCI_QUIRK_BROKEN_ERR_DATA_REPORTING for QCA
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <23ab1e90-fc3c-117c-01e2-bc73288b7d47@quicinc.com>
Date:   Tue, 26 Apr 2022 20:14:46 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <389C696B-0A23-4033-A047-922EB2E7A997@holtmann.org>
References: <1650012368-13505-1-git-send-email-quic_zijuhu@quicinc.com>
 <1D02DBF7-9368-43D5-9062-96CC73E22B57@holtmann.org>
 <23ab1e90-fc3c-117c-01e2-bc73288b7d47@quicinc.com>
To:     quic_zijuhu <quic_zijuhu@quicinc.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>>> Set HCI_QUIRK_BROKEN_ERR_DATA_REPORTING for QCA controllers since
>>> they answer HCI_OP_READ_DEF_ERR_DATA_REPORTING with error code
>>> "UNKNOWN HCI COMMAND" as shown below:
>>> 
>>> [ 580.517552] Bluetooth: hci0: unexpected cc 0x0c5a length: 1 < 2
>>> [ 580.517660] Bluetooth: hci0: Opcode 0x c5a failed: -38
>>> 
>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>>> ---
>>> drivers/bluetooth/btusb.c | 2 ++
>>> 1 file changed, 2 insertions(+)
>>> 
>>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>>> index 06a854a2507e..a33f8705f147 100644
>>> --- a/drivers/bluetooth/btusb.c
>>> +++ b/drivers/bluetooth/btusb.c
>>> @@ -3340,6 +3340,8 @@ static int btusb_setup_qca(struct hci_dev *hdev)
>>> 	 */
>>> 	set_bit(HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN, &hdev->quirks);
>>> 
>>> +	set_bit(HCI_QUIRK_BROKEN_ERR_DATA_REPORTING, &hdev->quirks);
>>> +
>>> 	return 0;
>>> }
>> 
>> please include the supported commands output from btmon that indicates that this hardware declares support for this command.
>> 
> hcitool -i hci0 cmd 0x04 0x02
> < HCI Command: ogf 0x04, ocf 0x0002, plen 0
>> HCI Event: 0x0e plen 68
> 01 02 10 00 FF FF FB 03 CE FF EF FF FF FF FF 1F F2 0F E8 FE
> 3F F7 8F FF 1C 00 04 00 61 FF FF FF 7F BE 20 F5 FF F0 FF FF
> FF FF FF FF FF EF FF FF FF FF 03 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00
> 
> btmon output:
> < HCI Command: Read Local Supported Commands (0x04|0x0002) plen 0 5.414488
>> HCI Event: Command Complete (0x0e) plen 68 5.419751
>      Read Local Supported Commands (0x04|0x0002) ncmd 1
>        Status: Success (0x00)
>        Commands: 288 entries
>          Inquiry (Octet 0 - Bit 0)
>          Inquiry Cancel (Octet 0 - Bit 1)
>          Periodic Inquiry Mode (Octet 0 - Bit 2)
>          Exit Periodic Inquiry Mode (Octet 0 - Bit 3)
>          Create Connection (Octet 0 - Bit 4)
>          Disconnect (Octet 0 - Bit 5)
>          Add SCO Connection (Octet 0 - Bit 6)
>          Create Connection Cancel (Octet 0 - Bit 7)
>          Accept Connection Request (Octet 1 - Bit 0)
>          Reject Connection Request (Octet 1 - Bit 1)
>          Link Key Request Reply (Octet 1 - Bit 2)
>          Link Key Request Negative Reply (Octet 1 - Bit 3)
>          PIN Code Request Reply (Octet 1 - Bit 4)
>          PIN Code Request Negative Reply (Octet 1 - Bit 5)
>          Change Connection Packet Type (Octet 1 - Bit 6)
>          Authentication Requested (Octet 1 - Bit 7)
>          Set Connection Encryption (Octet 2 - Bit 0)
>          Change Connection Link Key (Octet 2 - Bit 1)
>          Remote Name Request (Octet 2 - Bit 3)
>          Remote Name Request Cancel (Octet 2 - Bit 4)
>          Read Remote Supported Features (Octet 2 - Bit 5)
>          Read Remote Extended Features (Octet 2 - Bit 6)
>          Read Remote Version Information (Octet 2 - Bit 7)
>          Read Clock Offset (Octet 3 - Bit 0)
>          Read LMP Handle (Octet 3 - Bit 1)
>          Hold Mode (Octet 4 - Bit 1)
>          Sniff Mode (Octet 4 - Bit 2)
>          Exit Sniff Mode (Octet 4 - Bit 3)
>          QoS Setup (Octet 4 - Bit 6)
>          Role Discovery (Octet 4 - Bit 7)
>          Switch Role (Octet 5 - Bit 0)
>          Read Link Policy Settings (Octet 5 - Bit 1)
>          Write Link Policy Settings (Octet 5 - Bit 2)
>          Read Default Link Policy Settings (Octet 5 - Bit 3)
>          Write Default Link Policy Settings (Octet 5 - Bit 4)
>          Flow Specification (Octet 5 - Bit 5)
>          Set Event Mask (Octet 5 - Bit 6)
>          Reset (Octet 5 - Bit 7)
>          Set Event Filter (Octet 6 - Bit 0)
>          Flush (Octet 6 - Bit 1)
>          Read PIN Type (Octet 6 - Bit 2)
>          Write PIN Type (Octet 6 - Bit 3)
>          Read Stored Link Key (Octet 6 - Bit 5)
>          Write Stored Link Key (Octet 6 - Bit 6)
>          Delete Stored Link Key (Octet 6 - Bit 7)
>          Write Local Name (Octet 7 - Bit 0)
>          Read Local Name (Octet 7 - Bit 1)
>          Read Connection Accept Timeout (Octet 7 - Bit 2)
>          Write Connection Accept Timeout (Octet 7 - Bit 3)
>          Read Page Timeout (Octet 7 - Bit 4)
>          Write Page Timeout (Octet 7 - Bit 5)
>          Read Scan Enable (Octet 7 - Bit 6)
>          Write Scan Enable (Octet 7 - Bit 7)
>          Read Page Scan Activity (Octet 8 - Bit 0)
>          Write Page Scan Activity (Octet 8 - Bit 1)
>          Read Inquiry Scan Activity (Octet 8 - Bit 2)
>          Write Inquiry Scan Activity (Octet 8 - Bit 3)
>          Read Authentication Enable (Octet 8 - Bit 4)
>          Write Authentication Enable (Octet 8 - Bit 5)
>          Read Encryption Mode (Octet 8 - Bit 6)
>          Write Encryption Mode (Octet 8 - Bit 7)
>          Read Class of Device (Octet 9 - Bit 0)
>          Write Class of Device (Octet 9 - Bit 1)
>          Read Voice Setting (Octet 9 - Bit 2)
>          Write Voice Setting (Octet 9 - Bit 3)
>          Read Automatic Flush Timeout (Octet 9 - Bit 4)
>          Write Automatic Flush Timeout (Octet 9 - Bit 5)
>          Read Num Broadcast Retransmissions (Octet 9 - Bit 6)
>          Write Num Broadcast Retransmissions (Octet 9 - Bit 7)
>          Read Hold Mode Activity (Octet 10 - Bit 0)
>          Write Hold Mode Activity (Octet 10 - Bit 1)
>          Read Transmit Power Level (Octet 10 - Bit 2)
>          Read Sync Flow Control Enable (Octet 10 - Bit 3)
>          Write Sync Flow Control Enable (Octet 10 - Bit 4)
>          Set Controller To Host Flow Control (Octet 10 - Bit 5)
>          Host Buffer Size (Octet 10 - Bit 6)
>          Host Number of Completed Packets (Octet 10 - Bit 7)
>          Read Link Supervision Timeout (Octet 11 - Bit 0)
>          Write Link Supervision Timeout (Octet 11 - Bit 1)
>          Read Number of Supported IAC (Octet 11 - Bit 2)
>          Read Current IAC LAP (Octet 11 - Bit 3)
>          Write Current IAC LAP (Octet 11 - Bit 4)
>          Set AFH Host Channel Classification (Octet 12 - Bit 1)
>          Read Inquiry Scan Type (Octet 12 - Bit 4)
>          Write Inquiry Scan Type (Octet 12 - Bit 5)
>          Read Inquiry Mode (Octet 12 - Bit 6)
>          Write Inquiry Mode (Octet 12 - Bit 7)
>          Read Page Scan Type (Octet 13 - Bit 0)
>          Write Page Scan Type (Octet 13 - Bit 1)
>          Read AFH Channel Assessment Mode (Octet 13 - Bit 2)
>          Write AFH Channel Assessment Mode (Octet 13 - Bit 3)
>          Read Local Version Information (Octet 14 - Bit 3)
>          Read Local Supported Features (Octet 14 - Bit 5)
>          Read Local Extended Features (Octet 14 - Bit 6)
>          Read Buffer Size (Octet 14 - Bit 7)
>          Read BD ADDR (Octet 15 - Bit 1)
>          Read Failed Contact Counter (Octet 15 - Bit 2)
>          Reset Failed Contact Counter (Octet 15 - Bit 3)
>          Read Link Quality (Octet 15 - Bit 4)
>          Read RSSI (Octet 15 - Bit 5)
>          Read AFH Channel Map (Octet 15 - Bit 6)
>          Read Clock (Octet 15 - Bit 7)
>          Read Loopback Mode (Octet 16 - Bit 0)
>          Write Loopback Mode (Octet 16 - Bit 1)
>          Enable Device Under Test Mode (Octet 16 - Bit 2)
>          Setup Synchronous Connection (Octet 16 - Bit 3)
>          Accept Synchronous Connection Request (Octet 16 - Bit 4)
>          Reject Synchronous Connection Request (Octet 16 - Bit 5)
>          Read Extended Inquiry Response (Octet 17 - Bit 0)
>          Write Extended Inquiry Response (Octet 17 - Bit 1)
>          Refresh Encryption Key (Octet 17 - Bit 2)
>          Sniff Subrating (Octet 17 - Bit 4)
>          Read Simple Pairing Mode (Octet 17 - Bit 5)
>          Write Simple Pairing Mode (Octet 17 - Bit 6)
>          Read Local OOB Data (Octet 17 - Bit 7)
>          Read Inquiry Response TX Power Level (Octet 18 - Bit 0)
>          Write Inquiry Transmit Power Level (Octet 18 - Bit 1)
>          Read Default Erroneous Data Reporting (Octet 18 - Bit 2)
>          Write Default Erroneous Data Reporting (Octet 18 - Bit 3)
>          IO Capability Request Reply (Octet 18 - Bit 7)
>          User Confirmation Request Reply (Octet 19 - Bit 0)
>          User Confirmation Request Neg Reply (Octet 19 - Bit 1)
>          User Passkey Request Reply (Octet 19 - Bit 2)
>          User Passkey Request Negative Reply (Octet 19 - Bit 3)
>          Remote OOB Data Request Reply (Octet 19 - Bit 4)
>          Write Simple Pairing Debug Mode (Octet 19 - Bit 5)
>          Enhanced Flush (Octet 19 - Bit 6)
>          Remote OOB Data Request Neg Reply (Octet 19 - Bit 7)
>          Send Keypress Notification (Octet 20 - Bit 2)
>          IO Capability Request Negative Reply (Octet 20 - Bit 3)
>          Read Encryption Key Size (Octet 20 - Bit 4)
>          Set Event Mask Page 2 (Octet 22 - Bit 2)
>          Read Enhanced Transmit Power Level (Octet 24 - Bit 0)
>          Read LE Host Supported (Octet 24 - Bit 5)
>          Write LE Host Supported (Octet 24 - Bit 6)
>          LE Set Event Mask (Octet 25 - Bit 0)
>          LE Read Buffer Size (Octet 25 - Bit 1)
>          LE Read Local Supported Features (Octet 25 - Bit 2)
>          Octet 25 - Bit 3
>          LE Set Random Address (Octet 25 - Bit 4)
>          LE Set Advertising Parameters (Octet 25 - Bit 5)
>          LE Read Advertising Channel TX Power (Octet 25 - Bit 6)
>          LE Set Advertising Data (Octet 25 - Bit 7)
>          LE Set Scan Response Data (Octet 26 - Bit 0)
>          LE Set Advertise Enable (Octet 26 - Bit 1)
>          LE Set Scan Parameters (Octet 26 - Bit 2)
>          LE Set Scan Enable (Octet 26 - Bit 3)
>          LE Create Connection (Octet 26 - Bit 4)
>          LE Create Connection Cancel (Octet 26 - Bit 5)
>          LE Read White List Size (Octet 26 - Bit 6)
>          LE Clear White List (Octet 26 - Bit 7)
>          LE Add Device To White List (Octet 27 - Bit 0)
>          LE Remove Device From White List (Octet 27 - Bit 1)
>          LE Connection Update (Octet 27 - Bit 2)
>          LE Set Host Channel Classification (Octet 27 - Bit 3)
>          LE Read Channel Map (Octet 27 - Bit 4)
>          LE Read Remote Used Features (Octet 27 - Bit 5)
>          LE Encrypt (Octet 27 - Bit 6)
>          LE Rand (Octet 27 - Bit 7)
>          LE Start Encryption (Octet 28 - Bit 0)
>          LE Long Term Key Request Reply (Octet 28 - Bit 1)
>          LE Long Term Key Request Neg Reply (Octet 28 - Bit 2)
>          LE Read Supported States (Octet 28 - Bit 3)
>          LE Receiver Test (Octet 28 - Bit 4)
>          LE Transmitter Test (Octet 28 - Bit 5)
>          LE Test End (Octet 28 - Bit 6)
>          Octet 29 - Bit 1
>          Octet 29 - Bit 2
>          Enhanced Setup Synchronous Connection (Octet 29 - Bit 3)
>          Enhanced Accept Synchronous Connection Request (Octet 29 - Bit 4)
>          Read Local Supported Codecs (Octet 29 - Bit 5)
>          Set External Frame Configuration (Octet 29 - Bit 7)
>          Set Triggered Clock Capture (Octet 30 - Bit 5)
>          Set Connectionless Slave Broadcast (Octet 31 - Bit 0)
>          Start Synchronization Train (Octet 31 - Bit 2)
>          Set Reserved LT_ADDR (Octet 31 - Bit 4)
>          Delete Reserved LT_ADDR (Octet 31 - Bit 5)
>          Set Connectionless Slave Broadcast Data (Octet 31 - Bit 6)
>          Read Synchronization Train Parameters (Octet 31 - Bit 7)
>          Write Synchronization Train Parameters (Octet 32 - Bit 0)
>          Remote OOB Extended Data Request Reply (Octet 32 - Bit 1)
>          Read Secure Connections Host Support (Octet 32 - Bit 2)
>          Write Secure Connections Host Support (Octet 32 - Bit 3)
>          Read Authenticated Payload Timeout (Octet 32 - Bit 4)
>          Write Authenticated Payload Timeout (Octet 32 - Bit 5)
>          Read Local OOB Extended Data (Octet 32 - Bit 6)
>          Write Secure Connections Test Mode (Octet 32 - Bit 7)
>          LE Remote Connection Parameter Request Reply (Octet 33 - Bit 4)
>          LE Remote Connection Parameter Request Negative Reply (Octet 33 - Bit 5)
>          LE Set Data Length (Octet 33 - Bit 6)
>          LE Read Suggested Default Data Length (Octet 33 - Bit 7)
>          LE Write Suggested Default Data Length (Octet 34 - Bit 0)
>          LE Read Local P-256 Public Key (Octet 34 - Bit 1)
>          LE Generate DHKey (Octet 34 - Bit 2)
>          LE Add Device To Resolving List (Octet 34 - Bit 3)
>          LE Remove Device From Resolving List (Octet 34 - Bit 4)
>          LE Clear Resolving List (Octet 34 - Bit 5)
>          LE Read Resolving List Size (Octet 34 - Bit 6)
>          LE Read Peer Resolvable Address (Octet 34 - Bit 7)
>          LE Read Local Resolvable Address (Octet 35 - Bit 0)
>          LE Set Address Resolution Enable (Octet 35 - Bit 1)
>          LE Set Resolvable Private Address Timeout (Octet 35 - Bit 2)
>          LE Read Maximum Data Length (Octet 35 - Bit 3)
>          Octet 35 - Bit 4
>          Octet 35 - Bit 5
>          Octet 35 - Bit 6
>          Octet 35 - Bit 7
>          Octet 36 - Bit 0
>          Octet 36 - Bit 1
>          Octet 36 - Bit 2
>          Octet 36 - Bit 3
>          Octet 36 - Bit 4
>          Octet 36 - Bit 5
>          Octet 36 - Bit 6
>          Octet 36 - Bit 7
>          Octet 37 - Bit 0
>          Octet 37 - Bit 1
>          Octet 37 - Bit 2
>          Octet 37 - Bit 3
>          Octet 37 - Bit 4
>          Octet 37 - Bit 5
>          Octet 37 - Bit 6
>          Octet 37 - Bit 7
>          Octet 38 - Bit 0
>          Octet 38 - Bit 1
>          Octet 38 - Bit 2
>          Octet 38 - Bit 3
>          Octet 38 - Bit 4
>          Octet 38 - Bit 5
>          Octet 38 - Bit 6
>          Octet 38 - Bit 7
>          Octet 39 - Bit 0
>          Octet 39 - Bit 1
>          Octet 39 - Bit 2
>          Octet 39 - Bit 3
>          Octet 39 - Bit 4
>          Octet 39 - Bit 5
>          Octet 39 - Bit 6
>          Octet 39 - Bit 7
>          Octet 40 - Bit 0
>          Octet 40 - Bit 1
>          Octet 40 - Bit 2
>          Octet 40 - Bit 3
>          Octet 40 - Bit 4
>          Octet 40 - Bit 5
>          Octet 40 - Bit 6
>          Octet 40 - Bit 7
>          Octet 41 - Bit 0
>          Octet 41 - Bit 1
>          Octet 41 - Bit 2
>          Octet 41 - Bit 3
>          Octet 41 - Bit 5
>          Octet 41 - Bit 6
>          Octet 41 - Bit 7
>          Octet 42 - Bit 0
>          Octet 42 - Bit 1
>          Octet 42 - Bit 2
>          Octet 42 - Bit 3
>          Octet 42 - Bit 4
>          Octet 42 - Bit 5
>          Octet 42 - Bit 6
>          Octet 42 - Bit 7
>          Octet 43 - Bit 0
>          Octet 43 - Bit 1
>          Octet 43 - Bit 2
>          Octet 43 - Bit 3
>          Octet 43 - Bit 4
>          Octet 43 - Bit 5
>          Octet 43 - Bit 6
>          Octet 43 - Bit 7
>          Octet 44 - Bit 0
>          Octet 44 - Bit 1
>          Octet 44 - Bit 2
>          Octet 44 - Bit 3
>          Octet 44 - Bit 4
>          Octet 44 - Bit 5
>          Octet 44 - Bit 6
>          Octet 44 - Bit 7
>          Octet 45 - Bit 0
>          Octet 45 - Bit 1
>          Octet 45 - Bit 2
>          Octet 45 - Bit 3
>          Octet 45 - Bit 4
>          Octet 45 - Bit 5
>          Octet 45 - Bit 6
>          Octet 45 - Bit 7
>          Octet 46 - Bit 0
>          Octet 46 - Bit 1

you might want to use a recent btmon. However can you show how the Read Default Erroneous Data Reporting is failing? It sounds like this hardware is fundamentally broken.

Regards

Marcel

